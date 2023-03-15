//
//  LoginStorage.swift
//  TestApp
//
//  Created by Yulia Ignateva on 15.03.2023.
//

import Foundation

final class LoginStorage {
    static let shared = LoginStorage()
    
    init() {}
    
    private let keyForKeyChain = "User"
    private let serviceForKeyChain = "TestApp.com"
    private let keyChain = KeyChain()
    
    func save(login: String) {
        keyChain.save(login: login, key: keyForKeyChain, service: serviceForKeyChain)
    }
    
    func getLogin() -> String? {
        return keyChain.get(key: keyForKeyChain, service: serviceForKeyChain)
    }
    
    func delete(login: String) {
        keyChain.delete(login: login, key: keyForKeyChain, service: serviceForKeyChain)
    }
}
