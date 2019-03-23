//
//  ResponseShowUserBooking.swift
//  NaRogax
//
//  Created by User on 21/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation

struct ResponseShowUserBooking: Decodable {
    var bookings = [Bookings]()
}

struct Bookings: Decodable {
    var accepted: Bool
    var booking_id: Int
    var date_time_from: String
    var date_time_to: String
    var table_id: Int
    
    func configData() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM"
        let stringDate = dateFormatter.string(from: dateFormatter.date(from: date_time_from)!)
        dateFormatter.dateFormat = "hh:mm"
        let strTimeFrom = dateFormatter.string(from: dateFormatter.date(from: date_time_from)!)
        let strTimeTo = dateFormatter.string(from: dateFormatter.date(from: date_time_to)!)
        return stringDate + ", " + strTimeFrom + "-" + strTimeTo
    }
}
