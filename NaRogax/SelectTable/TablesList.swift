//
//  TableStruct.swift
//  NaRogax
//
//  Created by User on 11/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation

struct TablesList: Decodable {
    let data: [Table]
}

struct Table: Decodable {
    var chair_count = 0
    var chair_type = ""
    var position: String? = ""
    var table_id = 0
}
