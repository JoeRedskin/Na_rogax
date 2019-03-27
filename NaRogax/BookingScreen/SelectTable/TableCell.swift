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
            var tableCountString = ""
            if table.chair_count == 4 {
                tableCountString = String(table.chair_count) + " места"
            } else {
                tableCountString = String(table.chair_count) + " мест"
                    }
            TitleLabel.text = "Стол: № \(table_id) на \(tableCountString)"
        }
        
        if table.chair_type == "" {
            DescLabel.isHidden = true
        } else {
            if let pos = table.position{
                DescLabel.text = "\(table.chair_type.uppercased()), \(pos.uppercased())"
            } else {
                DescLabel.text = table.chair_type.uppercased()
            }
        }
        SelectBtn.layer.cornerRadius = 17
        SelectBtn.layer.borderColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
        SelectBtn.layer.borderWidth = 2
    }
    
    func displayCancelBooking(booking: Bookings, index: Int) {
        TitleLabel.text = booking.configData()
        TitleLabel.font = UIFont(name: TitleLabel.font.fontName, size: 17)
        SelectBtn.tag = index
        DescLabel.text = booking.configDesc()
        TitleLabel.font = UIFont(name: TitleLabel.font.fontName, size: 12)

        if (booking.accepted){
            SelectBtn.setTitle("Отменить", for: UIControl.State.normal)
            SelectBtn.layer.cornerRadius = 17
            SelectBtn.layer.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            SelectBtn.layer.borderWidth = 0
            SelectBtn.isUserInteractionEnabled = true
            SelectBtn.setImage(nil, for: UIControl.State.normal)
        }else{
            SelectBtn.setImage(UIImage(named: "ic_processed"), for: UIControl.State.normal)
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
