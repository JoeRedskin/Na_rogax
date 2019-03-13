//
//  TablePostData.swift
//  NaRogax
//
//  Created by User on 12/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation

struct ReserveDate: Encodable {
    var date = ""
    var time_from = ""
    var date_to = ""
    var time_to = ""
}

struct ReserveTableData: Encodable {
    var email = ""
    var name = ""
    var phone = ""
    var date = ""
    var time_from = ""
    var date_to = ""
    var time_to = ""
    var table_id = 0
}
