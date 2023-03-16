//
//  KeyChain.swift
//  TestApp
//
//  Created by Yulia Ignateva on 14.03.2023.
//

import UIKit
import Security


final class KeyChain {
    func save(login: String, key: String, service: String) {
        let login = login.data(using: String.Encoding.utf8)!
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key,
            kSecValueData: login
        ] as! CFDictionary
                     
        let status = SecItemAdd(query, nil)
        guard status == errSecSuccess else { return print("save error") }
    }
    
    func get(key: String, service: String) -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: true
        ] as! CFDictionary
        var result: AnyObject?
        let _ = SecItemCopyMatching(query, &result)
        
        guard let data = result as? Data else {return nil}
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    func delete(login: String, key: String, service: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key,
        ] as! CFDictionary
        
        let status = SecItemDelete(query)
        guard status == errSecSuccess else { return print("delete error") }
    }
}
