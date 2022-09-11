//
//  File.swift
//  
//
//  Created by José Neto on 11/09/2022.
//

import Foundation
import apiclient
import tools

public struct LoginManagerController {
    public static let shared: LoginManagerController = LoginManagerController()
    private let loginController: LoginManagerAPI = LoginManagerAPI()
    
    public func loginDevice(deviceId: String) async throws {
        let login = try? await loginController.deviceLogin(deviceId: deviceId)
        guard let token = login?.token else { return }
        KeychainStorage.shared.set(newValue: token, forKey: ConfigLoader.shared.appConfig.token)
    }
}
