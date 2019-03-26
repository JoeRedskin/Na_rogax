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
    var chair_count: Int
    var chair_type: String
    var position: String
    var date_time_from: String
    var date_time_to: String
    var table_id: Int
    
    func configData() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM"
        let stringDate = dateFormatter.string(from: getDate(str: date_time_to))
        dateFormatter.dateFormat = "HH:mm"
        let strTimeFrom = dateFormatter.string(from: getDate(str: date_time_from))
        let strTimeTo = dateFormatter.string(from: getDate(str: date_time_to))
        return stringDate + ", " + strTimeFrom + "-" + strTimeTo
    }
    
    func configDesc() -> String{
        var countStr = ""
        if chair_count == 4 {
            countStr = String(chair_count) + " места"
        } else {
            countStr = String(chair_count) + " мест"
        }
        return "Стол: № \(table_id) на \(countStr), \(position) \(chair_type)"
    }
    
    private func getDate(str: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.date(from: String(str))!
    }
}
