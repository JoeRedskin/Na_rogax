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
    @IBOutlet weak var timeDuration: LabelCell!
    
    func reloadData(){
        timeDuration.reloadColor(check: check)
        check = !check
    }
}
