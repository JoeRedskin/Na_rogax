//
//  DrinkPriceCell.swift
//  NaRogax
//
//  Created by User on 08/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class DrinkPriceCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    
    func displayPrice(price: String){
        
        if price == "" {
            priceLabel.text = "⏤ ₽"
        } else {
            priceLabel.text = price
        }
        
    }

}
