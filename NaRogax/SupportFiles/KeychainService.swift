//
//  KeychainService.swift
//  NaRogax
//
//  Created by User on 26/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation
import Security

class KeychainService {
    class func passwordQuery(service: String, account: String) -> Dictionary<String, Any>
    {
        let dictionary = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : account,
            kSecAttrService as String : service,
            kSecAttrAccessible as String : kSecAttrAccessibleWhenUnlocked //If need access in background, might want to consider kSecAttrAccessibleAfterFirstUnlock
            ] as [String : Any]
        
        return dictionary
    }
    
    @discardableResult class func setToken(_ token: String, service: String, account: String) -> Bool
    {
        var status : OSStatus = -1
        if !(service.isEmpty) && !(account.isEmpty)
        {
            deleteToken(service: service, account: account) //delete password if pass empty string. Could change to pass nil to delete password, etc
            
            if !token.isEmpty
            {
                var dictionary = passwordQuery(service: service, account: account)
                let dataFromString = token.data(using: String.Encoding.utf8, allowLossyConversion: false)
                dictionary[kSecValueData as String] = dataFromString
                status = SecItemAdd(dictionary as CFDictionary, nil)
            }
        }
        return status == errSecSuccess
    }
    
    @discardableResult class func deleteToken(service: String, account: String) -> Bool
    {
        var status : OSStatus = -1
        if !(service.isEmpty) && !(account.isEmpty)
        {
            let dictionary = passwordQuery(service: service, account: account)
            status = SecItemDelete(dictionary as CFDictionary);
        }
        return status == errSecSuccess
    }
    
    ///return empty string if not found, could return an optional
    class func token(service: String, account: String) -> String{
        var status : OSStatus = -1
        var resultString = ""
        if !(service.isEmpty) && !(account.isEmpty)
        {
            var passwordData : AnyObject?
            var dictionary = passwordQuery(service: service, account: account)
            dictionary[kSecReturnData as String] = kCFBooleanTrue
            dictionary[kSecMatchLimit as String] = kSecMatchLimitOne
            status = SecItemCopyMatching(dictionary as CFDictionary, &passwordData)
            
            if status == errSecSuccess
            {
                if let retrievedData = passwordData as? Data
                {
                    resultString = String(data: retrievedData, encoding: String.Encoding.utf8)!
                }
            }
        }
        return resultString
    }
}


