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
    
    public func loginDevice(deviceId: String) async {
        let login = try? await loginController.deviceLogin(deviceId: deviceId)
        guard let token = login?.token else { return }
        guard let key: String = ConfigLoader.shared.appConfig?.token else { return }
        try? KeychainStorage.shared.set(newValue: token, forKey: key)
    }
}
