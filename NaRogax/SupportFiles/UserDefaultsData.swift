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

    init() {}
    
    static func shared() -> UserDefaultsData {
        if uniqueInstance == nil {
            uniqueInstance = UserDefaultsData()
        }
        return uniqueInstance!
    }
    
    func saveEmail(){
        
    }
    
    func saveName(){
        
    }
    
}
