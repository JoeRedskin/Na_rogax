//
//  RequestPostDeleteUserBooking.swift
//  NaRogax
//
//  Created by User on 21/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation
import Alamofire

struct RequestPostDeleteUserBooking {
    var email = ""
    var uuid = ""
    var booking_id = -1
    
    func conventParameters() -> Parameters{
        let par: Parameters = [ "email": email,
                                "uuid": uuid,
                                "booking_id": booking_id]
        return par
    }
}
