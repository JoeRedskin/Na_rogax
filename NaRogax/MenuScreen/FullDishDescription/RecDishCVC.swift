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
    @IBOutlet weak var MinusStepper: UIButton!
    @IBOutlet weak var PlusStepper: UIButton!
    @IBOutlet weak var CountLabel: UILabel!
    
    var AddCount: Int = 1 {
        didSet {
            CountLabel.text = String(AddCount)
        }
    }
    
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
        //AddToCartBtn.layer.borderWidth = 1
        //AddToCartBtn.layer.borderColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
        AddToCartBtn.layer.cornerRadius = 12
        
        PlusStepper.layer.cornerRadius = 2
        PlusStepper.layer.borderWidth = 1
        PlusStepper.layer.borderColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
        
        MinusStepper.layer.cornerRadius = 2
        MinusStepper.layer.borderWidth = 1
        MinusStepper.layer.borderColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
        
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
    
    func changeState(active: Bool){
        AddToCartBtn.isHidden = !active
        MinusStepper.isHidden = active
        PlusStepper.isHidden = active
        CountLabel.isHidden = active
    }
    
    @IBAction func onAddToCartTap(_ sender: UIButton) {
        changeState(active: false)
    }
    
    @IBAction func decCount(_ sender: UIButton) {
        if AddCount == 1 {
            changeState(active: true)
            AddCount = 1
        } else {
            AddCount -= 1
        }
        if AddCount == 14 {
            PlusStepper.layer.backgroundColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
        }
    }
    
    @IBAction func incCount(_ sender: UIButton) {
        if AddCount < 15 {
            AddCount += 1
            if AddCount == 15 {
               PlusStepper.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            }
        } 
    }
}
