//
//  ResponseUserCredentials.swift
//  NaRogax
//
//  Created by User on 23/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation

struct ResponseUserCredentials: Decodable {
    var data: DataResponse
}

struct DataResponse: Decodable {
    var email: String
    var birthday: String
    var name: String
    var phone: String
    var reg_date: String
}
