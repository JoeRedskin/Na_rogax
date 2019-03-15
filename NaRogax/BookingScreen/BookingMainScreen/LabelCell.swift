//
//  LabelCell.swift
//  NaRogax
//
//  Created by User on 12/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class LabelCell: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initial()
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        initial()
    }
    
    func initial() {
        clipsToBounds = true
        layer.cornerRadius = 4
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1978887078)
    }
}
