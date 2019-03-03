//
//  FullDescCViCell.swift
//  NaRogax
//
//  Created by User on 27/02/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class FullDescCViCell: UICollectionViewCell {
    
    @IBOutlet weak var recImage: UIImageView!
    @IBOutlet weak var recName: UILabel!
    @IBOutlet weak var recPrice: UILabel!
    @IBOutlet weak var recWeight: UILabel!
    

    func displayDish(dish: DishDescription){

        if dish.name == ""{
            recName.text = "Без наименования"
        } else {
            recName.text = dish.name
        }

        if dish.weight == ""{
            recWeight.isHidden = true
        } else {
            recWeight.text = dish.weight + " г"
        }

        if dish.price == nil{
            recPrice.text = "⏤ р"
        } else {
            recPrice.text = String(dish.price!) + " р"
        }

        if dish.photo == ""{
            recImage.image = UIImage(named: "no_image")
        } else {
            fetchImage(url_img: dish.photo)
        }

    }
    
    func fetchImage(url_img: String) {
        if let url = URL(string: url_img){
            //spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents {
                        self?.recImage.image = UIImage(data: imageData)
                        //self?.spinner.stopAnimating()
                    }
                }
            }
        }
    }
}
