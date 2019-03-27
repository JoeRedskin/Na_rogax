//
//  AuthorizeUser.swift
//  NaRogax
//
//  Created by User on 20/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation

struct ResponseAuthorizeUser: Decodable {
    var code = 0
    var desc = ""
    var email = ""
    var access_token = ""
}
