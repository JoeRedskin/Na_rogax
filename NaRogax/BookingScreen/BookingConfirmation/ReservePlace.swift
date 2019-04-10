//
//  PostReservePlace.swift
//  NaRogax
//
//  Created by User on 12/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation

struct PostReservePlace: Codable {
    var email: String
    var name: String
    var phone: String
    var date: String
    var date_to: String
    var time_from: String
    var time_to: String
    var table_id: Int
}

struct ResponseReservePlace: Decodable {
    var code: Int
    var desc: String
    
    enum CodingKeys: String, CodingKey{
        case code = "code"
        case desc = "desc"
    }
}
