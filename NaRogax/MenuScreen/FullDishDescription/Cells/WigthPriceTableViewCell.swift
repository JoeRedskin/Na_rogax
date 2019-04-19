//
//  WigthPlaceTableViewCell.swift
//  NaRogax
//
//  Created by User on 09/04/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class WigthPriceTableViewCell: UITableViewCell {

    @IBOutlet weak var labelWigth: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(dish: DishDescription) {
        let dimension = dish.className == "НАПИТКИ" ? "мл" : "г"
        if let weight = dish.weight{
            if !weight.isEmpty{
                labelWigth.text = "\(weight) \(dimension)"
            }
        }
        if let price = dish.price {
            labelPrice.text = "\(price) ₽"
        } else {
            labelPrice.text = "⏤ ₽"
        }
    }
    
}
