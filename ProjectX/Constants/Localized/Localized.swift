//
//  Localized.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Utilities

extension LocalizedKey where Self == Keys.Common {
    static var common: Keys.Common.Type { Keys.Common.self }
    static var message: Keys.Message.Type { Keys.Message.self }
    static var setting: Keys.Setting.Type { Keys.Setting.self }
}
