//
//  TimeDurationCVC.swift
//  NaRogax
//
//  Created by User on 12/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class TimeDurationCVC: UICollectionViewCell {
    private var check = false
    
    func reloadSelected(){
        check = !check
    }
    
    /*func reloadColor(check: Bool){
        if (check){
            timeDuration.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1978887078)
            timeDuration.layer.borderWidth = 1
        }else{
            timeDuration.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            timeDuration.layer.borderWidth = 3
        }
    }*/
}
