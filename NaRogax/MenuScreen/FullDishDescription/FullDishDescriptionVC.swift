//
//  FullDishDescriptionVC.swift
//  NaRogax
//
//  Created by User on 09/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class FullDishDescriptionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    @IBOutlet weak var ImageBGView: GradientView!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var DescLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var WeightLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var RecomendedCollectionView: UICollectionView!
    @IBOutlet weak var RecommendLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var dishFull = ResponseDishesList(categories: [])
    var indexOfDish = 0
    var indexOfCategory = 0
    var recDish: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        backButton.title = "Меню"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        GetValuesInView(menu: dishFull.categories[indexOfCategory].cat_dishes[indexOfDish])
        ImageBGView.clipsToBounds = true
        ImageBGView.layer.cornerRadius = 16.0
        
        RecomendedCollectionView.delegate = self
        RecomendedCollectionView.dataSource = self
        RecomendedCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func GetValuesInView(menu: DishDescription){
        
        if menu.name == ""{
            NameLabel.text = "Без наимменования"
        } else {
            NameLabel.text = menu.name
        }
        
        if let desc = menu.longDescription {
            if desc == "" {
                DescLabel.isHidden = true
            } else {
                //print(menu.longDescription!)
                DescLabel.text = desc
            }
        } else {
            if menu.name.contains("Лимонад") {
                DescLabel.text = "Стекло"
            } else {
                DescLabel.text = ""
            }
        }
        
        if menu.weight == ""{
            WeightLabel.isHidden = true
        } else {
            if menu.name.contains("Сок") || menu.name.contains("Лимонад") || menu.name.contains("Пиво"){
                WeightLabel.text = menu.weight + " мл"
            } else {
                WeightLabel.text = menu.weight
            }
        }
         
         if menu.price == nil{
            PriceLabel.text = "⏤ ₽"
         } else {
            PriceLabel.text = String(menu.price!)+" ₽"
         }
        
        if menu.recommendedWith == nil {
            RecomendedCollectionView.isHidden = true
            RecommendLabel.isHidden = true
            scrollView.isScrollEnabled = false
        } else {
            recStringToMassive()
        }
        
        if menu.photo == "" || menu.photo == nil{
            Image.image = UIImage(named: "no_image")
        } else {
            fetchImage(url_img: menu.photo!)
        }
        
    }
    
    func fetchImage(url_img: String) {
        if let url = URL(string: url_img){
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents {
                        self?.Image.image = UIImage(data: imageData)
                        self?.spinner.stopAnimating()
                    }
                }
            }
        }
    }
    
    func recStringToMassive(){
        if let recDishString = dishFull.categories[indexOfCategory].cat_dishes[indexOfDish].recommendedWith{
            var str = ""
            for index in recDishString.indices{
                if (recDishString[index] >= "0" && recDishString[index] <= "9") {
                    str += String(recDishString[index])
                    if index.encodedOffset == recDishString.count-1{
                        recDish.append(str)
                        str = ""
                        break;
                    }
                } else {
                    recDish.append(str)
                    str = ""
                }
            }
        }
    }
    
    func findRecDish(topping: Int) -> DishDescription{
        var rightDish = DishDescription()
        for category in dishFull.categories{
                for dish in category.cat_dishes{
                    if dish.itemId == topping{
                        rightDish = dish
                    }
                }
        }
        return rightDish
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if dishFull.categories[indexOfCategory].cat_dishes[indexOfDish].recommendedWith == nil {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecDish", for: indexPath) as! RecDishCVC
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecDish", for: indexPath) as! RecDishCVC
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        cell.displayDish(dish: findRecDish(topping: Int(recDish[indexPath.row])!))
        return cell
    }
}


