//
//  Cell.swift
//  NaRogax
//
//  Created by User on 15/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    
    @IBOutlet weak var lable: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //inital()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //inital()
    }
    
    private func inital(){
        lable.clipsToBounds = true
        lable.layer.cornerRadius = 4
        lable.layer.borderWidth = 1
        lable.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1978887078)
    }
    
    func setDate(dateCVC date: DateCVC){
        lable.text = date.text
        reloadColor(check: date.check)
    }
    
    private func reloadColor(check: Bool){
        if (check){
            lable.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            lable.layer.borderWidth = 3
            lable.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            lable.layer.cornerRadius = 4
        }else{
            lable.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1978887078)
            lable.layer.borderWidth = 1
            lable.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1978887078)
            lable.layer.cornerRadius = 4
        }
    }
}
