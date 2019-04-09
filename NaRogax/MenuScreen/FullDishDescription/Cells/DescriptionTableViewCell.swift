//
//  DescriptionTableViewCell.swift
//  NaRogax
//
//  Created by User on 09/04/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var labelLongDescDish: UILabel!
    @IBOutlet weak var labelWeightDish: UILabel!
    @IBOutlet weak var labelPriceDish: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(dish: DishDescription){
        if let desc = dish.longDescription {
            if desc == "" {
                labelLongDescDish.isHidden = true
            } else {
                labelLongDescDish.text = desc
            }
        } else {
            labelLongDescDish.isHidden = true
        }
        /*if let weight = dish.weight {
            if weight == "" {
                labelWeightDish.isHidden = true
            } else {
                if dish.className == "НАПИТКИ"{
                    labelWeightDish.text = "\(weight) мл"
                } else {
                    labelWeightDish.text = "\(weight) г"
                }
            }
        } else {
            labelWeightDish.isHidden = true
        }
        
        if let price = dish.price {
            labelPriceDish.text = "\(price) ₽"
        } else {
            labelPriceDish.text = "⏤ ₽"
        }*/
    }
}
