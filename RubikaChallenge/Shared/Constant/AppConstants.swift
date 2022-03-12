//
//  AppConstants.swift
//  CodeChallenge
//
//  Created by MohammadReza Zamanieh on 3/3/22.
//

import Foundation
import UIKit



class AppConstant: NSObject {
    
    public static let instance = AppConstant()
    public static let datasource = DataSourceManager()
    public static let k = K()
    
    private let userDefault = UserDefaults.standard
    
    
    public func _initialize() {
        

    }
    
    public func initUI() {
        let vm = Feature.vm.init(type: .style, body: .init(type: nil, size: nil, extras: []))
        let vc = Feature.vc.init(vm: vm)
        let nav = UINavigationController.init(rootViewController: vc)
        Z.ui.switch(window: nav)
    }
    
    public func tokenReturn() -> String? {
        return self.setting_load(for: .access_token) as? String
    }

    
    // MARK: - Settings
    enum Settings_App: String {
        case access_token
    }
    
    public func setting_load(for key: Settings_App) -> Any? {
        return userDefault.value(forKey: key.rawValue)
    }
    
    public func setting_save(_ value: Any?, for key: Settings_App) {
        userDefault.setValue(value, forKey: key.rawValue)
    }
    
    public func setting_delete(for key: Settings_App) {
        userDefault.removeObject(forKey: key.rawValue)
    }
    
}

