//
//  DishTableViewCell.swift
//  NaRogax
//
//  Created by User on 01/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class DishTableViewCell: UITableViewCell {

    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var dishSpinner: UIActivityIndicatorView!
    @IBOutlet weak var dishName: UILabel!
    @IBOutlet weak var dishShortInfo: UILabel!
    @IBOutlet weak var dishPrice: UILabel!
    
    
    func displayDish(dish: DishDescription){
        
        if dish.name == ""{
            dishName.text = "Без наименования"
        } else {
            dishName.text = dish.name
        }
        
        if dish.shortDescription == ""{
            dishShortInfo.isHidden = true
        } else {
            dishShortInfo.text = dish.shortDescription
        }
        
        if dish.price == nil{
            dishPrice.text = "--- р"
        } else {
            dishPrice.text = String(dish.price!) + " р"
        }
        
        if dish.photo == ""{
            dishImage.image = UIImage(named: "no_image")
        } else {
            fetchImage(url_img: dish.photo)
        }
        
    }
    
    func fetchImage(url_img: String) {
        if let url = URL(string: url_img){
            dishSpinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents {
                        self?.dishImage.image = UIImage(data: imageData)
                        self?.dishSpinner.stopAnimating()
                    }
                }
            }
        }
    }
    
    
}
