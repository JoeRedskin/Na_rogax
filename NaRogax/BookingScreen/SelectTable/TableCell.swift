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
    
    var table_id = 0
    
    func displayTable(table: Table, index: Int) {
        self.table_id = table.table_id
        SelectBtn.tag = index
        if String(table.chair_count) == "" {
            TitleLabel.text = "Без названия"
        } else {
            if table.chair_count == 4 {
                
                if let pos = table.position {
                    if pos != "" {
                        TitleLabel.text = String(table.chair_count) + " места, " + pos
                    } else {
                        TitleLabel.text = String(table.chair_count) + " места"
                    }
                } else {
                    TitleLabel.text = String(table.chair_count) + " места"
                }
                
            } else {
                if let pos = table.position {
                    if pos != "" {
                        TitleLabel.text = String(table.chair_count) + " мест, " + pos
                    } else {
                        TitleLabel.text = String(table.chair_count) + " мест"
                    }
                } else {
                    TitleLabel.text = String(table.chair_count) + " мест"
                }
            }
        }
        
        if table.chair_type == "" {
            DescLabel.isHidden = true
        } else {
            DescLabel.text = table.chair_type.uppercased()
        }
        SelectBtn.layer.cornerRadius = 17
        SelectBtn.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        SelectBtn.layer.borderWidth = 2
    }
    
    func displayCancelBooking(booking: Bookings, index: Int) {
        TitleLabel.text = booking.configData()
        TitleLabel.font = UIFont(name: TitleLabel.font.fontName, size: 17)
        SelectBtn.tag = index

        if (booking.accepted){
            SelectBtn.setTitle("Отменить", for: UIControl.State.normal)
            SelectBtn.layer.cornerRadius = 17
            SelectBtn.layer.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            SelectBtn.layer.borderWidth = 0
            SelectBtn.isUserInteractionEnabled = true
        }else{
            SelectBtn.setImage(UIImage(named: "processed"), for: UIControl.State.normal)
            SelectBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: UIControl.State.normal)
            SelectBtn.setTitle("", for: UIControl.State.normal)
            SelectBtn.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            SelectBtn.isUserInteractionEnabled = false
            SelectBtn.layer.cornerRadius = 0
            SelectBtn.layer.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 0)
            SelectBtn.layer.borderWidth = 0
        }
        

    }
    
}
