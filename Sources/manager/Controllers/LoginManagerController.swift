//
//  File.swift
//  
//
//  Created by José Neto on 11/09/2022.
//

import Foundation
import UIKit
import apiclient
import tools

public class LoginManagerController {
    public static let shared: LoginManagerController = LoginManagerController()
    private let loginController: LoginManagerAPI = LoginManagerAPI()
    
    public func loginDevice() async {
        guard let deviceId: String = await UIDevice.current.identifierForVendor?.uuidString else { return }
        let login = try? await loginController.deviceLogin(deviceId: deviceId)
        guard let token = login?.token else { return }
        let key: String = ConfigLoader.shared.appConfig.token
        try? KeychainStorage.shared.set(newValue: token, forKey: key)
    }
}
