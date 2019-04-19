//
//  ErrorResponse.swift
//  NaRogax
//
//  Created by User on 20/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation

struct ErrorResponse: Decodable {
    var code: Int
    var desc: String
    
    enum CodingKeys: String, CodingKey{
        case code = "code"
        case desc = "desc"
    }
}
