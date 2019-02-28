//
//  BorderedButton.swift
//  NaRogax
//
//  Created by User on 26/02/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class BorderedButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 1.0
        layer.borderColor = tintColor.cgColor
        layer.cornerRadius = 5.0
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        setTitleColor(tintColor, for: .Normal)
        setTitleColor(UIColor.white, for: .highlighted)
        setBackgroundImage(UIImage(color: tintColor), for: .Highlighted)
    }
}
