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
    
    /*
     Spacing between cells in tableView
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }

    
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
            dishPrice.text = "⏤ р"
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
                DispatchQueue.main.async {
//                    dishImage.kf.placeholder = Placeholder.add(to: UIImage(named: "no_image"))
                    self?.dishImage.kf.setImage(with: url)
                    self?.dishSpinner.stopAnimating()
                }
            }
        }
    }
}
