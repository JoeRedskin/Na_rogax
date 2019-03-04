//
//  DishCollectionViewCell.swift
//  NaRogax
//
//  Created by User on 21/02/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

//import UIKit
//
//class DishCollectionViewCell: UICollectionViewCell{
//    
//    @IBOutlet weak var dishImage: UIImageView!
//    
//    @IBAction func dishDetailButton(_ sender: UIButton) {
//    }
//    
//    @IBOutlet weak var spinner: UIActivityIndicatorView!
//    @IBOutlet weak var dishNameLabel: UILabel!
//    @IBOutlet weak var shortDishDescription: UILabel!
//    @IBOutlet weak var dishPrice: UILabel!
//    
//    func displayDish(dish: DishDescription){
//        
//        if dish.name == ""{
//           dishNameLabel.text = "Без наименования"
//        } else {
//           dishNameLabel.text = dish.name
//        }
//        
//        if dish.shortDescription == ""{
//            shortDishDescription.isHidden = true
//        } else {
//            shortDishDescription.text = dish.shortDescription
//        }
//        
//        if dish.price == nil{
//            dishPrice.text = "--- р"
//        } else {
//            dishPrice.text = String(dish.price!) + " р"
//        }
//        
//        if dish.photo == ""{
//            dishImage.image = UIImage(named: "no_image")
//        } else {
//           fetchImage(url_img: dish.photo)
//        }
//        
//    }
//    
//    func fetchImage(url_img: String) {
//        if let url = URL(string: url_img){
//            spinner.startAnimating()
//            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//                let urlContents = try? Data(contentsOf: url)
//                DispatchQueue.main.async {
//                    if let imageData = urlContents {
//                        self?.dishImage.image = UIImage(data: imageData)
//                        self?.spinner.stopAnimating()
//                    }
//                }
//            }
//        }
//    }
//}
