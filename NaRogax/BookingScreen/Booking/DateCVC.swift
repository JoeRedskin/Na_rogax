//
//  CollectionViewCell.swift
//  NaRogax
//
//  Created by User on 12/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class DateCVC: UICollectionViewCell {
    private var check = false
    @IBOutlet weak var date: LabelCell!

    func reloadData(){
        date.reloadColor(check: check)
        check = !check
    }
}
