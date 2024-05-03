//
//  UserDefaultsManager.swift
//  CoreModule
//
//  Created by Hoàng Hiệp Lê on 3/5/24.
//

import Foundation

enum UserDefaultsKey {
    static let isLogin = "IS_LOGIN"
}

public class UserDefaultsManager {
    static var isLogin: Bool {
        get {
            UserDefaults.get(forKey: UserDefaultsKey.isLogin) as? Bool ?? false
        }
        set {
            UserDefaults.set(newValue, forKey: UserDefaultsKey.isLogin)
        }
    }
}
