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
    @IBOutlet weak var AddToCartBtn: UIButton!
    
    func displayDish(dish: DishDescription){
        
        if dish.name == ""{
            NameLabel.text = "Без наименования"
        } else {
            NameLabel.text = dish.name
        }
        
        if dish.weight == ""{
            WeightLabel.isHidden = true
        } else {
            WeightLabel.text = dish.weight + " г"
        }
        
        if dish.price == nil{
            PriceLabel.text = "⏤ р"
            print(dish.price!)
        } else {
            PriceLabel.text = String(dish.price!) + " р"
        }
        
        if dish.photo == ""{
            Image.image = UIImage(named: "no_image")
        } else {
            //fetchImage(url_img: dish.photo)
            Image.image = UIImage(named: "no_image")
        }
        //AddToCartBtn.layer.borderWidth = 1
        //AddToCartBtn.layer.borderColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
        AddToCartBtn.layer.cornerRadius = 15
        
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
