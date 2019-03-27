//
//  RequestPostReservePlace.swift
//  NaRogax
//
//  Created by User on 20/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation
import Alamofire

struct RequestPostReservePlace {
    var email = ""
    var date = ""
    var time_from = ""
    var date_to = ""
    var time_to = ""
    var table_id = 0
    
    func conventParameters() -> Parameters{
        let par: Parameters = [
            "email": email,
            "date":  date,
            "time_from": time_from,
            "date_to": date_to,
            "time_to":  time_to,
            "table_id": table_id]
        return par
    }
}
