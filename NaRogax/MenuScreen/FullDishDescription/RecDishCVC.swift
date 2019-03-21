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
    
    func displayDish(dish: DishDescription){
        
        if dish.name == ""{
            NameLabel.text = "Без наименования"
        } else {
            NameLabel.text = dish.name
        }
        
        if dish.weight == ""{
            WeightLabel.isHidden = true
        } else {
            if dish.name.contains("Сок") || dish.name.contains("Чай") || dish.name.contains("Кофе") || dish.name.contains("Лимонад") || dish.name.contains("Пиво") {
                WeightLabel.text = dish.weight + " мл"
            } else {
                WeightLabel.text = dish.weight + " г"
            }
        }
        
        if dish.price == nil{
            PriceLabel.text = "⏤ ₽"
            print(dish.price!)
        } else {
            PriceLabel.text = String(dish.price!) + " ₽"
        }
        
        if dish.photo == ""{
            Image.image = UIImage(named: "no_image")
        } else {
            fetchImage(url_img: dish.photo)
            //Image.image = UIImage(named: "no_image")
        }
    }
    
    func fetchImage(url_img: String) {
        if let url = URL(string: url_img){
            //spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents {
                        self?.Image.image = UIImage(data: imageData)
                        //self?.spinner.stopAnimating()
                    }
                }
            }
        }
    }
}
