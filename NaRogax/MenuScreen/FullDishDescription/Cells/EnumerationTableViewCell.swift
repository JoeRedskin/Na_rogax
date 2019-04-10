//
//  enumeration enumeration EnumerationTableViewCell.swift
//  NaRogax
//
//  Created by User on 09/04/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class EnumerationTableViewCell: UITableViewCell {
    private var enumarionArray = [SubMenu]()
    private var cat = ""
    
    @IBOutlet weak var tableEnumeration: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableEnumeration.delegate = self
        tableEnumeration.dataSource = self
    }
    
    
    func setDate(array: [SubMenu], category: String) {
        enumarionArray = array
        cat = category
        tableEnumeration.reloadData()
    }
}

extension EnumerationTableViewCell: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return enumarionArray.count
    }
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < enumarionArray.count{
            print("SubMenu enumarionArray", tableView.frame.height)
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "DrinkCell", for: indexPath) as! DrinkDescriptionCell
            var dishName = ""
            let dimension = cat == "НАПИТКИ" ? "мл" : "г"
            if let name = enumarionArray[indexPath.row].name{
                if name.isEmpty{
                    dishName = "\(enumarionArray[indexPath.row].weight ?? "") \(dimension)"
                }else{
                    dishName = "\(name), " + "\(enumarionArray[indexPath.row].weight ?? "") \(dimension)"
                }
            }
            cell.displayDish(name: dishName, price: String(enumarionArray[indexPath.row].price!))
            return cell
        }
        return UITableViewCell()
    }
}
