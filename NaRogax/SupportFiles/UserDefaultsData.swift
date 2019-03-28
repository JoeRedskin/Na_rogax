//
//  UserDefaultsData.swift
//  NaRogax
//
//  Created by User on 27/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation

class UserDefaultsData {
    private static var uniqueInstance: UserDefaultsData?

    private let EMAIL_KEY = "email"
    private let NAME_KEY = "name"
    private let PHONE_KEY = "phone"
    private let BIRTH_DATE_KEY = "birthDate"
    
    
    private init() {}
    
    static func shared() -> UserDefaultsData {
        if uniqueInstance == nil {
            uniqueInstance = UserDefaultsData()
        }
        return uniqueInstance!
    }
    
    func saveEmail(email: String){
        UserDefaults.standard.set(email, forKey: EMAIL_KEY)
    }
    
    func saveName(name: String){
        UserDefaults.standard.set(name, forKey: NAME_KEY)
    }
    
    func savePhone(phone: String){
        UserDefaults.standard.set(phone, forKey: PHONE_KEY)
    }
    
    func savePhone(birthDate: String){
        UserDefaults.standard.set(birthDate, forKey: PHONE_KEY)
    }
    
    func getEmail() -> String{
        return UserDefaults.standard.string(forKey: EMAIL_KEY) ?? ""
    }
    
    func getName() -> String{
        return UserDefaults.standard.string(forKey: NAME_KEY) ?? ""
    }

    func getPhone() -> String{
        return UserDefaults.standard.string(forKey: PHONE_KEY) ?? ""
    }
    
    func getBirthDate() -> String{
        return UserDefaults.standard.string(forKey: BIRTH_DATE_KEY) ?? ""
    }
}
