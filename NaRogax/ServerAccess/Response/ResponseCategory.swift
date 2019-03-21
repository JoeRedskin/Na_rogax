//
//  ResponseCategory.swift
//  NaRogax
//
//  Created by User on 21/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation
struct ResponseCategory: Decodable{
    let categories: [Category]
    enum CodingKeys: String, CodingKey {
        case categories
    }
}

struct Category: Decodable {
    var class_id: Int
    var name: String
    var order: Int
    
    enum CodingKeys: String, CodingKey{
        case class_id = "class_id"
        case name = "name"
        case order = "order"
    }
}
