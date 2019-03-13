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
    @IBOutlet weak var minusStepperBtn: UIButton!
    @IBOutlet weak var plusStepperBtn: UIButton!
    @IBOutlet weak var stepperCountLabel: UILabel!
    
    var count: Int = 0 {
        didSet{
            stepperCountLabel.text = String(count)
        }
    }
    
    

    func displayDish(dish: String){
        
        minusStepperBtn.layer.borderWidth = 1.0
        minusStepperBtn.layer.borderColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
        minusStepperBtn.layer.cornerRadius = 2.0
        //minusStepperBtn.titleLabel?.textAlignment = NSTextAlignment.center
        
        plusStepperBtn.layer.borderWidth = 1.0
        plusStepperBtn.layer.borderColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
        plusStepperBtn.layer.cornerRadius = 2.0
        //plusStepperBtn.titleLabel?.textAlignment = NSTextAlignment.center
        
        if dish == "" {
            drinkName.text = "Без наимменования"
        } else {
            drinkName.text = dish
        }
        
    }
    
    
    @IBAction func incCount(_ sender: UIButton) {
        if count < 15 {
            count += 1
            minusStepperBtn.layer.backgroundColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
        }
        if count == 15 {
           plusStepperBtn.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        }
    }
    
    @IBAction func decCount(_ sender: UIButton) {
        if count > 0 {
            count -= 1
            if count == 0 {
                minusStepperBtn.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            }
            if count == 14 {
                plusStepperBtn.layer.backgroundColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
            }
        }
    }
    

}
