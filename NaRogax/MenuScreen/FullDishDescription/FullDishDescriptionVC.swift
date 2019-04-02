//
//  FullDishDescriptionVC.swift
//  NaRogax
//
//  Created by User on 09/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class FullDishDescriptionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var descriptionGradient: GradientView!
    @IBOutlet weak var descriptionNameLabel: UILabel!
    @IBOutlet weak var descriptionLongDescriptionLabel: UILabel!
    @IBOutlet weak var descriptionSpinner: UIActivityIndicatorView!
    @IBOutlet weak var descriptionWeightLabel: UILabel!
    @IBOutlet weak var descriptionPriceLabel: UILabel!
    
    @IBOutlet weak var descriptionRecommendedCollectionView: UICollectionView!
    @IBOutlet weak var descriptionRecommendLabel: UILabel!
    @IBOutlet weak var descriptionScrollView: UIScrollView!
    @IBOutlet weak var descriptionImage: UIImageView!
    
    var dishFullDescription = ResponseDishesList(categories: [])
    var indexOfDish = 0
    var indexOfCategory = 0
    var recommendedDishes: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        backButton.title = "Меню"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        GetValuesInView(menu: dishFullDescription.categories[indexOfCategory].cat_dishes[indexOfDish])
        
        descriptionRecommendedCollectionView.delegate = self
        descriptionRecommendedCollectionView.dataSource = self
        descriptionRecommendedCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func GetValuesInView(menu: DishDescription) {
        
        if menu.name == "" {
            descriptionNameLabel.text = "Без наимменования"
        } else {
            descriptionNameLabel.text = menu.name
        }
        
        if let desc = menu.longDescription {
            if desc == "" {
                descriptionLongDescriptionLabel.isHidden = true
            } else {
                descriptionLongDescriptionLabel.text = desc
            }
        } else {
            if menu.name.contains("Лимонад") {
                descriptionLongDescriptionLabel.text = "Стекло"
            } else {
                descriptionLongDescriptionLabel.text = ""
            }
        }
        
        if let weight = menu.weight {
            if weight == "" {
                descriptionWeightLabel.isHidden = true
            } else {
                if menu.class_name == "НАПИТКИ"{
                    descriptionWeightLabel.text = "\(weight) мл"
                } else {
                    descriptionWeightLabel.text = "\(weight) г"
                }
            }
        } else {
            descriptionWeightLabel.isHidden = true
        }
        
        
        if let price = menu.price {
            descriptionPriceLabel.text = "\(price) ₽"
        } else {
            descriptionPriceLabel.text = "⏤ ₽"
        }
        
        if menu.recommendedWith == nil {
            descriptionRecommendedCollectionView.isHidden = true
            descriptionRecommendLabel.isHidden = true
            descriptionScrollView.isScrollEnabled = false
        } else {
            recommendedStringToMassive()
        }
        
        if menu.photo == "" || menu.photo == nil {
            descriptionImage.image = UIImage(named: "no_image")
        } else {
            fetchImage(url_img: menu.photo!)
        }
    }
    
    func fetchImage(url_img: String) {
        if let url = URL(string: url_img){
            descriptionSpinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents {
                        self?.descriptionImage.image = UIImage(data: imageData)
                        self?.descriptionSpinner.stopAnimating()
                    }
                }
            }
        }
    }
    
    func recommendedStringToMassive() {
        if let recommendedDishesString = dishFullDescription.categories[indexOfCategory].cat_dishes[indexOfDish].recommendedWith {
            var str = ""
            for index in recommendedDishesString.indices {
                if (recommendedDishesString[index] >= "0" && recommendedDishesString[index] <= "9") {
                    str += String(recommendedDishesString[index])
                    if index.encodedOffset == recommendedDishesString.count - 1{
                        recommendedDishes.append(str)
                        str = ""
                        break;
                    }
                } else {
                    recommendedDishes.append(str)
                    str = ""
                }
            }
        }
    }
    
    func findRecommendedDishes(topping: Int) -> DishDescription {
        var rightRecommendedDish = DishDescription()
        for category in dishFullDescription.categories {
            for dish in category.cat_dishes {
                if dish.itemId == topping {
                    rightRecommendedDish = dish
                }
            }
        }
        return rightRecommendedDish
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedDishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if dishFullDescription.categories[indexOfCategory].cat_dishes[indexOfDish].recommendedWith == nil {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecDish", for: indexPath) as! RecommendedDishCVC
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecDish", for: indexPath) as! RecommendedDishCVC
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        cell.displayDish(dish: findRecommendedDishes(topping: Int(recommendedDishes[indexPath.row])!))
        return cell
    }
}
