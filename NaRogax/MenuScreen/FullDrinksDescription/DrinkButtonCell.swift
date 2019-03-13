//
//  DrinkButtonCell.swift
//  NaRogax
//
//  Created by User on 08/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class DrinkButtonCell: UITableViewCell {

    @IBOutlet weak var addToCartBtn: UIButton!
    
    func displayBtn(){
        
        addToCartBtn.layer.cornerRadius = 20
        addToCartBtn.layer.borderWidth = 3
        addToCartBtn.layer.borderColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
        
    }

}
