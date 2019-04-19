//
//  RequestPostAuth.swift
//  NaRogax
//
//  Created by User on 20/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation
import Alamofire

struct RequestPostAuth {
    var email = ""
    var password = ""
    
    func conventParameters() -> Parameters{
        let par: Parameters = [ "email": email,
                                "password": password]
        return par
    }
}
