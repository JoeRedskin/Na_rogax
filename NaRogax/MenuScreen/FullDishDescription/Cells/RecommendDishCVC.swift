//
//  RecDishCVC.swift
//  NaRogax
//
//  Created by User on 09/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class RecommendedDishCVC: UICollectionViewCell {
    
    @IBOutlet weak var recommendedDishNameLabel: UILabel!
    @IBOutlet weak var recommendedDishWeightLabel: UILabel!
    @IBOutlet weak var recommendedDishPriceLabel: UILabel!
    @IBOutlet weak var recommendedDishImage: UIImageView!
    @IBOutlet weak var ImageSpinner: UIActivityIndicatorView!
    
    /**
     Display recommend dish on full dish description screen
     - Parameters:
        - dish: Dish struct
     */
    
    func displayDish(dish: DishDescription) {
        
        if dish.name == "" {
            recommendedDishNameLabel.text = "Без наименования"
        } else {
            recommendedDishNameLabel.text = dish.name
        }
        
        if let weight = dish.weight {
            if weight == "" {
                recommendedDishWeightLabel.isHidden = true
            } else {
                if dish.className == "НАПИТКИ" {
                    recommendedDishWeightLabel.text = "\(weight) мл"
                } else {
                    recommendedDishWeightLabel.text = "\(weight) г"
                }
            }
        } else {
            recommendedDishWeightLabel.isHidden = true
        }

        if let price = dish.price {
            recommendedDishPriceLabel.text = "\(price) ₽"
        } else {
            if dish.subMenu?.count ?? -1 > 0{
                var price = dish.subMenu!.sorted(by: { ($0.price ?? -1) < $1.price ?? -1 })
                if price[0].price! > 0{
                    recommendedDishPriceLabel.text = "от \(price[0].price!) ₽"
                }else{
                    recommendedDishPriceLabel.text = "⏤ ₽"
                }
            }else {
                recommendedDishPriceLabel.text = "⏤ ₽"
            }
        }
        
        if dish.photo == "" || dish.photo == nil {
            recommendedDishImage.image = UIImage(named: "no_image")
        } else {
            fetchImage(url_img: dish.photo!)
        }
    }
    
    func fetchImage(url_img: String) {
        if let url = URL(string: url_img){
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents {
                        self?.recommendedDishImage.image = UIImage(data: imageData)
                        self?.ImageSpinner.stopAnimating()
                        self?.ImageSpinner.isHidden = true
                    }
                }
            }
        }
    }
}
