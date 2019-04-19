//
//  ResponseChangeUserCredentials.swift
//  NaRogax
//
//  Created by User on 23/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation

struct ResponseChangeUserCredentials: Decodable {
    var code: Int
    var desc: String
    var email: String?
    var access_token: String?
}
