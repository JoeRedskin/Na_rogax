//
//  DishTableViewCell.swift
//  NaRogax
//
//  Created by User on 01/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit
import Kingfisher

class DishTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var dishSpinner: UIActivityIndicatorView!
    @IBOutlet weak var dishName: UILabel!
    @IBOutlet weak var dishShortInfo: UILabel!
    @IBOutlet weak var dishPrice: UILabel!
    @IBOutlet weak var dishGradient: UIView!
    @IBOutlet weak var borderView: UIView!
    
    func displayDish(dish: DishDescription){
        
        borderView.layer.cornerRadius = 4
        borderView.layer.borderWidth = 0.25
        borderView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1986915261)
        
        if dish.name == ""{
            dishName.text = "Без наименования"
        } else {
            dishName.text = dish.name
        }
        if dish.shortDescription == ""{
            dishShortInfo.isHidden = true
        } else {
            dishShortInfo.text = dish.shortDescription
            dishShortInfo.isHidden = false
            if dish.className == "НАПИТКИ"{
                if dish.subMenu?.count ?? -1 > 0{
                    var identical = false
                    var previusMl: [String.SubSequence]?
                    var ml: [String.SubSequence]?
                    for item in dish.subMenu!{
                        ml = item.weight?.split(separator: ",")
                        if previusMl != nil{
                            if ml != nil{
                                identical = ml![0] == previusMl![0]
                            }
                        }else{
                            previusMl = ml
                            identical = true
                        }
                    }
                    if identical{
                        if ml != nil{
                            if let text = dish.shortDescription{
                                dishShortInfo.text = "\(text)\n" + String(ml![0]) + " мл"
                            }else{
                                dishShortInfo.text = String(ml![0]) + " мл"
                            }
                        }
                    }
                }
            }
        }
        
        if let price = dish.price {
            dishPrice.text = "\(price) ₽"
        } else if dish.name.contains("Лимонад") {
            guard let price1 = dish.subMenu![0].price else {return}
            guard let price2 = dish.subMenu![1].price else {return}
            
            dishPrice.text = "\(price1) / \(price2) ₽"
        } else {
            dishPrice.text = "⏤ ₽"
        }
        
        if dish.photo == "" || dish.photo == nil{
            dishImage.image = UIImage(named: "no_image")
        } else {
            fetchImage(url_img: dish.photo!)
        }
        
    }
    
    func fetchImage(url_img: String) {
        if let url = URL(string: url_img){
            dishSpinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                DispatchQueue.main.async {
                    self?.dishImage.kf.setImage(with: url)
                    self?.dishSpinner.stopAnimating()
                }
            }
        }
    }
}
