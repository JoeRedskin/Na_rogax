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
    private var isToday: Bool = false
    
    var date: String = ""

    
    init(numberDay item: Int) {
        setData(item: item)
    }
    
    init(text: String) {
        self.text = text
    }
    
    func reloadToday() {
        isToday = !isToday
    }
    
    func checkToday() -> Bool {
        return isToday
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
        text = format.string(from: date)
        setLocDate(date: date)
    }
    
    //преобразует дату и сохраняет
    private func setLocDate(date: Date){
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        format.locale = Locale(identifier: "ru_RU")
        self.date = format.string(from: date)
    }
    
    func getDay() -> String{
        return String(text.split(separator: "\n")[1])
    }
}
