//
//  RecDishCVC.swift
//  NaRogax
//
//  Created by User on 09/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class RecDishCVC: UICollectionViewCell {
    
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var WeightLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    
    /**
     Display recommend dish on full dish description screen
     - Parameters:
        - dish: Dish struct
     */
    
    func displayDish(dish: DishDescription){
        
        if dish.name == ""{
            NameLabel.text = "Без наименования"
        } else {
            NameLabel.text = dish.name
        }
        
        if let weight = dish.weight{
            if weight == ""{
                WeightLabel.isHidden = true
            } else {
                if dish.name.contains("Сок") || dish.name.contains("Чай") || dish.name.contains("Кофе") || dish.name.contains("Лимонад") || dish.name.contains("Пиво") {
                    WeightLabel.text = weight + " мл"
                } else {
                    WeightLabel.text = weight + " г"
                }
            }
        }else{
            WeightLabel.isHidden = true
        }
        
        
        if dish.price == nil{
            if dish.name.contains("Лимонад") {
                
                var price = "⏤"
                
                if let price1 = dish.sub_menu![0].price {
                    price = String(price1)
                }
                
                if let price2 = dish.sub_menu![1].price {
                    if price != "⏤" {
                        price += " / "
                    } else {
                        price = ""
                    }
                    price += String(price2)
                }
                
                price += " ₽"
                
                PriceLabel.text = price
                
            } else {
                PriceLabel.text = "⏤ ₽"
            }
        } else {
            PriceLabel.text = String(dish.price!) + " ₽"
        }

        
        /*if dish.price == nil{
            PriceLabel.text = "⏤ ₽"
            print(dish.price!)
        } else {
            PriceLabel.text = String(dish.price!) + " ₽"
        }*/
        
        if dish.photo == "" || dish.photo == nil{
            Image.image = UIImage(named: "no_image")
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
                        self?.Image.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
}
