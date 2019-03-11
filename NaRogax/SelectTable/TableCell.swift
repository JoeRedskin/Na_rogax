//
//  TableCell.swift
//  NaRogax
//
//  Created by User on 11/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var DescLabel: UILabel!
    @IBOutlet weak var SelectBtn: UIButton!
    
    func displayTable(table: Table) {
        if table.title == "" {
            TitleLabel.text = "Без названия"
        } else {
            TitleLabel.text = table.title
        }
        
        if table.desc == "" {
            DescLabel.text = "Без описания"
        } else {
            DescLabel.text = table.desc
        }
        SelectBtn.layer.cornerRadius = 17
        SelectBtn.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        SelectBtn.layer.borderWidth = 2
    }

}
