//
//  RequestPostRegUser.swift
//  NaRogax
//
//  Created by User on 20/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation
import Alamofire

struct RequestPostRegUser {
    var email = ""
    var password = ""
    var code = 0
    var name = ""
    var phone = ""
    
    func conventParameters() -> Parameters{
        let par: Parameters = [
            "email": email,
            "password": password,
            "code": code,
            "name":  name,
            "phone":  phone]
        return par
    }
}
