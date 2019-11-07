//
//  UserManager.swift
//  AppleLoginExample
//
//  Created by 张行 on 2019/9/20.
//  Copyright © 2019 张行. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefaultProperty<V> {
    let key: String
    let `default`: V
    ///  wrappedValue是@propertyWrapper必须要实现的属性
    /// 当操作我们要包裹的属性时  其具体set get方法实际上走的都是wrappedValue 的set get 方法。
    var wrappedValue: V {
        get {
            UserDefaults.standard.object(forKey: self.key) as? V ?? self.default
        }
        set {
            UserDefaults.standard.set(newValue, forKey: self.key)
        }
    }
}

class UserManager {
    
    struct UserManagerKey {
        static let manager = UserManager()
    }
    
    static func manager() -> UserManager {
        return UserManagerKey.manager
    }
    
    @UserDefaultProperty(key: "aaa", default: false)
    var isLogin: Bool
    
    @UserDefaultProperty(key: "userName", default: "admin")
    var userName: String
    
    @UserDefaultProperty(key: "hahha", default: true)
    var hahha: Bool
}

struct UserConfig {
    @UserDefaultProperty(key: "age", default: 0)
    static var age: UInt
}
