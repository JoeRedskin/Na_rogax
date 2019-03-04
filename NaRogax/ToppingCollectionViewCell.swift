////
////  ToppingCollectionViewCell.swift
////  NaRogax
////
////  Created by User on 01/03/2019.
////  Copyright © 2019 Zappa. All rights reserved.
////
//
//import UIKit
//
//class ToppingCollectionViewCell: UICollectionViewCell {
//    
//    @IBOutlet weak var topImage: UIImageView!
//    @IBOutlet weak var topName: UILabel!
//    @IBOutlet weak var topWeight: UILabel!
//    @IBOutlet weak var topPrice: UILabel!
//    @IBOutlet weak var topSpinner: UIActivityIndicatorView!
//
//    @IBAction func topAdd(_ sender: BorderedButton) {
//    }
//    
//    func displayDish(dish: DishDescription){
//        
//        if dish.name == ""{
//            topName.text = "Без наименования"
//        } else {
//            topName.text = dish.name
//        }
//        
//        if dish.weight == nil{
//            topWeight.isHidden = true
//        } else {
//            topWeight.text = String(dish.weight!) + " г"
//        }
//        
//        if dish.price == nil{
//            topPrice.text = "--- р"
//        } else {
//            topPrice.text = String(dish.price!) + " р"
//        }
//        
//        if dish.photo == ""{
//            topImage.image = UIImage(named: "no_image")
//        } else {
//            fetchImage(url_img: dish.photo)
//        }
//        
//    }
//    
//    func fetchImage(url_img: String) {
//        if let url = URL(string: url_img){
//            topSpinner.startAnimating()
//            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//                let urlContents = try? Data(contentsOf: url)
//                DispatchQueue.main.async {
//                    if let imageData = urlContents {
//                        self?.topImage.image = UIImage(data: imageData)
//                        self?.topSpinner.stopAnimating()
//                    }
//                }
//            }
//        }
//    }
//
//    
//    
//    
//}
