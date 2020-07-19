//
//  User.swift
//  VTB_HW6
//
//  Created by Anton Tolstov on 09.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation

struct User {
    
    // MARK: - Properties
    
    let login: String
    let password: String
    
    // MARK: - Initializers
        
    init?(login: String, password: String) {
        guard login.count >= 6, password.count >= 6 else { return nil }
        
        self.login = login
        self.password = password
        
        saveUser()
    }
    
    init?() {
        let defaults = UserDefaults.standard
        guard let login = defaults.string(forKey: Constant.loginKey),
            let password = defaults.string(forKey: Constant.passwordKey) else {
            return nil
        }
        
        self.login = login
        self.password = password
    }
    
    // MARK: - Private Functions
    
    private func saveUser() {
        let defaults = UserDefaults.standard
        defaults.set(login, forKey: Constant.loginKey)
        defaults.set(password, forKey: Constant.passwordKey)
    }
    
    // MARK: - Constants
    
    private enum Constant {
        static let loginKey = "loginKey"
        static let passwordKey = "passwordKey"
    }
    
    static let minPasswordAndLoginLength = 6
}
