//
//  TablePostData.swift
//  NaRogax
//
//  Created by User on 12/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation
import Alamofire

struct RequestPostEmptyPlaces {
    var date = ""
    var time_from = ""
    var date_to = ""
    var time_to = ""
    
    func conventParameters() -> Parameters{
        let par: Parameters = [
        "date": date,
        "time_from": time_from,
        "date_to": date_to,
        "time_to":  time_to]
        return par
    }
}
