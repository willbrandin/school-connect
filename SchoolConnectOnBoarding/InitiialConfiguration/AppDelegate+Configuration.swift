//
//  AppDelegate+Configuration.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 1/30/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift
import RocketNetworking

extension AppDelegate: SchoolColorable {
    
    // MARK: - Methods
    
    func setupKeyboard() {
        IQKeyboardManager.shared.enable = true
    }
    
    func configureNetworkEnvironment() {
        guard let buildModeString = Bundle.main.infoDictionary!["BuildMode"] as? String,
            let buildMode = Int(buildModeString),
            let environment = getEnvironment(from: buildMode) else {
            print("Networking Layer could not be configured.")
            return
        }
        configureNetworkManager(in: environment)
    }
    
    // MARK: - Private Methods
    
    private func getEnvironment(from buildMode: Int) -> NetworkEnvironment? {
        switch buildMode {
        case 1: return .development
        case 2: return .qa
        case 3: return .staging
        case 4: return .production
        default:
            print("BuildModeInt does not match environment")
            return nil
        }
    }
    
    private func configureNetworkManager(in environment: NetworkEnvironment) {
        NetworkManager.setEnvironment(for: environment)
    }
}
