import XCTest
import Combine
import apiclient
import storageclient

@testable import manager

final class managerTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    func testApodController() throws {
        let controller = ApodManagerController(pathToSqlite: nil)
        let mock = ApodStorage()
        mock.id = UUID()
        mock.title = "MockTitle"
        mock.postedDate = Date()
        try controller.saveItems([mock])
        
        let countEmittedExpected: Int = 3
        let apodPublisher = controller.$items.collect(countEmittedExpected).first()
        let counterArray = try awaitPublisher(apodPublisher)
        XCTAssertEqual(countEmittedExpected, counterArray.count)
        
        let array: [Apod]? = counterArray.last ?? []
        XCTAssertEqual(array?.first?.id, mock.id)
    }
    
    func testLoginController() async throws {
        let controller = LoginManagerController.shared
        let deviceId: String = UUID().uuidString
        let token = await controller.loginDevice(deviceId: deviceId)
        XCTAssertNotNil(token)
    }
    
    func testTimelineController() throws {
        let timelineYear = TimelineYear.currentYear
        XCTAssertEqual(Date().year.string, timelineYear.value)
        XCTAssertEqual(Date().month, timelineYear.months.count)
        
        let timelineMonth = TimelineMonth.currentMonth
        let currentMonth = Date().string(withFormat: "MMMM, YYYY")
        XCTAssertEqual(currentMonth, timelineMonth.title)
        
        let startMonth = Date().beginning(of: .month)?.string(withFormat: "yyyy-MM-dd")
        XCTAssertEqual(startMonth, timelineMonth.startMonth)
        
        let endMonth = Date().end(of: .month)?.string(withFormat: "yyyy-MM-dd")
        XCTAssertEqual(endMonth, timelineMonth.endMonth)
        
        let firstYear = 2015
        let todayYear = Date().year
        let count = todayYear - firstYear + 1 // + 1 current year
        
        let years = TimelineYear.years
        XCTAssertEqual(count, years.count)
        
        let countEmittedExpected: Int = 1
        let timelinePublisher = TimelineController().$timeline.collect(countEmittedExpected).first()
        let counterArray = try awaitPublisher(timelinePublisher)
        
        XCTAssertEqual(countEmittedExpected, counterArray.count)
        
        let timelineA = TimelineYear.currentYear
        let timelineB = TimelineYear.currentYear
        
        XCTAssertEqual(timelineA, timelineB)
        
        let timelineMonthA = TimelineMonth.currentMonth
        let timelineMonthB = TimelineMonth.currentMonth
        
        XCTAssertEqual(timelineMonthA, timelineMonthB)
        
        var yearSetItems: Set = [timelineA, timelineB]
        if let timelineC = TimelineYear.years.last {
            if !yearSetItems.contains(timelineC) {
                yearSetItems.insert(timelineC)
            }
            // Set collection will not repeat same item.
            let expectedSetCount: Int = 2
            XCTAssertEqual(yearSetItems.count, expectedSetCount)
        }
        
        var monthSetItems: Set = [timelineMonthA, timelineMonthB]
        if let timelineC = TimelineYear.years.last?.months.last {
            if !monthSetItems.contains(timelineC) {
                monthSetItems.insert(timelineC)
            }
            // Set collection will not repeat same item.
            let expectedSetCount: Int = 2
            XCTAssertEqual(monthSetItems.count, expectedSetCount)
        }
        
        let currentMonthTest: TimelineMonth = TimelineMonth.currentMonth
        XCTAssertNotEqual(currentMonthTest.startMonth, currentMonthTest.endMonth)
    }
}

extension XCTestCase {
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        // This time, we use Swift's Result type to keep track
        // of the result of our Combine pipeline:
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )

        // Just like before, we await the expectation that we
        // created at the top of our test, and once done, we
        // also cancel our cancellable to avoid getting any
        // unused variable warnings:
        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        // Here we pass the original file and line number that
        // our utility was called at, to tell XCTest to report
        // any encountered errors at that original call site:
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        return try unwrappedResult.get()
    }
}
