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
    @IBOutlet weak var dishButton: BorderedLabel!
    
    @IBOutlet weak var BorderView: UIView!
    
    func displayDish(dish: DishDescription){
        
        BorderView.layer.cornerRadius = 4
        BorderView.layer.borderWidth = 0.25
        BorderView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1986915261)
        
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
        }
        
        if dish.price == nil{
            dishPrice.text = "⏤ ₽"
        } else {
            dishPrice.text = String(dish.price!) + " ₽"
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
//                    dishImage.kf.placeholder = Placeholder.add(to: UIImage(named: "no_image"))
                    self?.dishImage.kf.setImage(with: url)
                    self?.dishSpinner.stopAnimating()
                }
            }
        }
    }
}
