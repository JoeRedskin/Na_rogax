//
//  CollectionViewCell.swift
//  NaRogax
//
//  Created by User on 12/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class DateCVC: UICollectionViewCell {
    var check = false
    @IBOutlet weak var date: LabelCell!

    func reloadSelected(){
        reloadColor(check: check)
        check = !check
    }
    
    func reloadColor(check: Bool){
        if (check){
            date.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1978887078)
            date.layer.borderWidth = 1
        }else{
            date.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            date.layer.borderWidth = 3
        }
    }
}
