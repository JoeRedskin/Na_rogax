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
            
            dishShortInfo.text = getDescWeight(dish: dish)
            dishShortInfo.isHidden = false
            if dish.className == "НАПИТКИ"{
                dishShortInfo.text = getDrinks(dish: dish)
            }
        }
        
        if let price = dish.price {
            dishPrice.text = "\(price) ₽"
        } else {
            if dish.subMenu?.count ?? -1 > 0{
                var price = dish.subMenu!.sorted(by: { ($0.price ?? -1) < $1.price ?? -1 })
                if price[0].price! > 0{
                    dishPrice.text = "от \(price[0].price!) ₽"
                }else{
                    dishPrice.text = "⏤ ₽"
                }
            }else {
                dishPrice.text = "⏤ ₽"
            }
        }
        
        if dish.photo == "" || dish.photo == nil{
            dishImage.image = UIImage(named: "no_image")
        } else {
            fetchImage(url_img: dish.photo!)
        }
        
    }
    
    private func getDescWeight(dish: DishDescription) -> String{
        let shortDesc = dish.shortDescription ?? ""
        let weight = dish.weight ?? ""
        if shortDesc.isEmpty{
            return weight + " г"
        }else{
            if weight.isEmpty{
                return shortDesc
            }else{
                return shortDesc + "\n" + weight + " г"
            }
        }
    }
    
    private func getDrinks(dish: DishDescription) -> String{
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
                        return "\(text)\n" + String(ml![0]) + " мл"
                    }else{
                        return String(ml![0]) + " мл"
                    }
                }
            }
        }
        return ""
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
