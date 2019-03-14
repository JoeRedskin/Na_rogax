//
//  Timetable.swift
//  NaRogax
//
//  Created by User on 14/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation
import UIKit

struct Timetable: Decodable {

    let data: [TimeForDay]
    enum CodingKeys: CodingKey {
        case data
    }
}

struct TimeForDay: Decodable {
    
    var time_from: String
    var time_to: String
    var week_day: String
    
    enum CodingKeys: CodingKey {
        case time_from
        case time_to
        case week_day
    }
}


