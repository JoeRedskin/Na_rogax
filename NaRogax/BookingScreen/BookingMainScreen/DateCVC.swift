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
    
    init(numberDay item: Int) {
        setData(item: item)
    }
    
    init(text: String) {
        self.text = text
    }
    
    func reload(){
        check = !check
    }
    
    private func setData(item: Int){
        let format = DateFormatter()
        format.dateFormat = "dd\nEE"
        format.locale = Locale(identifier: "ru_RU")
        var date = Calendar.current.date(byAdding: .day, value: item, to: Date())!
        text = format.string(from: date)
    }
}
