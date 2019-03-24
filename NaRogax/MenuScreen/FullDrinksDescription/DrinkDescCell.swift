//
//  DrinkDescCell.swift
//  NaRogax
//
//  Created by User on 08/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class DrinkDescCell: UITableViewCell {
    
    @IBOutlet weak var drinkName: UILabel!    
    @IBOutlet weak var drinkPrice: UILabel!
    
    func displayDish(dish: String, price: String){
       
        if dish == "" {
            drinkName.text = "Без наимменования"
        } else {
            drinkName.text = dish
        }
        
        if price == "" {
            drinkPrice.text = "⏤ ₽"
        } else {
            drinkPrice.text = price + " ₽"
        }
    }
}
