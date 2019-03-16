//
//  CollectionViewCell.swift
//  NaRogax
//
//  Created by User on 12/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class DateCVC {
    var check = false
    var text: String = ""
    var date: String = ""
    
    init(numberDay item: Int) {
        setData(item: item)
    }
    
    init(text: String) {
        self.text = text
    }
    
    func reload(){
        check = !check
    }
    
    //установка даты
    private func setData(item: Int){
        let format = DateFormatter()
        format.dateFormat = "dd\nEE"
        format.locale = Locale(identifier: "ru_RU")
        let date = Calendar.current.date(byAdding: .day, value: item, to: Date())!
        print("setDate", date)
        text = format.string(from: date)
        setLocDate(date: date)
    }
    
    //преобразует дату и сохраняет
    private func setLocDate(date: Date){
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        format.locale = Locale(identifier: "ru_RU")
        self.date = format.string(from: date)
        print("setDateLoc", date)
    }
    
    //для сервера
    //возращает дату в ячейке и расчитывает дату до какого бронируют
    func getDate(timeTo time: String) -> (date: String, dateTo: String){
        var dateTo = ""
        switch time.split(separator: ":")[0] {
        case "01", "00":
            let splitDate = date.split(separator: "-")
            var day: Int = Int(splitDate[2]) ?? 0
            day += 1
            dateTo = splitDate[0] + "-" + splitDate[1] + "-" + String(day)
            break
        default:
            dateTo = date
            break
        }
        return (date, dateTo)
    }
}
