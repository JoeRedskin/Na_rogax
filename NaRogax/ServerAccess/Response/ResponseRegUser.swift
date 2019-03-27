//
//  ResponseRegUser.swift
//  NaRogax
//
//  Created by User on 27/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation

struct ResponseRegUser: Decodable {
    var code: Int
    var desc: String
    var access_token: String
    var email: String
}
