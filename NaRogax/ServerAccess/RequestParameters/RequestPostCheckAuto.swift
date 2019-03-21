//
//  RequestPostCheckAuto.swift
//  NaRogax
//
//  Created by User on 21/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation
import Alamofire

struct RequestPostCheckAuto {
    var email = ""
    var code = ""
    
    func conventParameters() -> Parameters{
        let par: Parameters = [ "email": email,
                                "code": code]
        return par
    }
}
