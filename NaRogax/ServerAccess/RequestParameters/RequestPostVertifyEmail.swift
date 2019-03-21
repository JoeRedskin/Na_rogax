//
//  RequestPostVertifyEmail.swift
//  NaRogax
//
//  Created by User on 20/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation
import Alamofire

struct RequestPostVertifyEmail {
    var email = ""
    
    func conventParameters() -> Parameters{
        let par: Parameters = [ "email": email]
        return par
    }
}
