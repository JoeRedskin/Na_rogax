//
//  DrinkDescCell.swift
//  NaRogax
//
//  Created by User on 08/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class DrinkDescriptionCell: UITableViewCell {
    
    @IBOutlet weak var drinkName: UILabel!    
    @IBOutlet weak var drinkPrice: UILabel!
    
    func displayDish(name: String, price: String){
       
        if name == "" {
            drinkName.text = "Без наимменования"
        } else {
            drinkName.text = name
        }
        
        if price == "" {
            drinkPrice.text = "⏤ ₽"
        } else {
            drinkPrice.text = "\(price) ₽"
        }
    }
}
