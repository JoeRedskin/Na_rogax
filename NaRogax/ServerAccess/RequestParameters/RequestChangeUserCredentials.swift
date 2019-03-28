//
//  RequestChangeUserCredentials.swift
//  NaRogax
//
//  Created by User on 23/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation
import Alamofire

struct RequestChangeUserCredentials {
    var email: String
    var new_email: String
    var code: String
    var name: String
    var phone: String
    var birthday: String
    
    func conventParameters() -> Parameters{
        let par: Parameters = [ "email": email,
                                "new_email": new_email,
                                "code": code,
                                "name": name,
                                "birthday": birthday,
                                "phone": phone]
        return par
    }
}
