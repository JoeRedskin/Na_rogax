//
//  FullDescriptionVC.swift
//  NaRogax
//
//  Created by User on 26/02/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class FullDescriptionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var RecomendedCollectionView: UICollectionView!
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        navigationController?.hidesBarsOnSwipe = false
//        navigationController?.setNavigationBarHidden(false, animated: true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetValuesInView(menu: dishFull[0].categories[indexOfCategory].cat_dishes[indexOfDish])
        recStringToMassive()
        RecomendedCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var nameField: UILabel!    
    @IBOutlet weak var desc_longField: UILabel!
    @IBOutlet weak var weightField: UILabel!
    @IBOutlet weak var priceField: UILabel!
    
    var dishFull: [ResponseDishesList] = []
    var indexOfDish = 0
    var indexOfCategory = 0
    var recDish: [String] = []
    
    func GetValuesInView(menu: DishDescription){
        
        if menu.name == ""{
            nameField.text = "Без наимменования"
        } else {
            nameField.text = menu.name
        }
        
        if menu.longDescription == ""{
            desc_longField.isHidden = true
        } else {
            desc_longField.text = menu.longDescription
        }
        
        if menu.weight == ""{
             weightField.isHidden = true
        } else {
            weightField.text = menu.weight + " г"
        }
        
        if menu.price == nil{
            priceField.text = "⏤ р"
        } else {
            priceField.text = String(menu.price!)+" р"
        }
        
        fetchImage(url_img: menu.photo!)
        
    }
    
    func fetchImage(url_img: String) {
        if let url = URL(string: url_img){
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents {
                        self?.imageField.image = UIImage(data: imageData)
                        self?.spinner.stopAnimating()
                    }
                }
            }
        }
    }
    
    func recStringToMassive(){
        if let recDishString = dishFull[0].categories[indexOfCategory].cat_dishes[indexOfDish].recommendedWith{
            //print(recDishString)
            var str = ""
            for index in recDishString.indices{
                if (recDishString[index] >= "0" && recDishString[index] <= "9") {
                    str += String(recDishString[index])
                    if index.encodedOffset == recDishString.count-1{
                       // print(str)
                        recDish.append(str)
                        //print(recDish)
                        str = ""
                        break;
                    }
                } else {
                    //print(str)
                    recDish.append(str)
                    //
                    str = ""
                }
            }
        }
    }
    
    func findRecDish(topping: Int) -> DishDescription{
        //print(topping)
        var rightDish = DishDescription()
        for category in dishFull[0].categories{
            //print(category.cat_name)
            if category.cat_name == "Топинги" || category.cat_name == "Напитки"{
                for dish in category.cat_dishes{
                    if dish.itemId == topping{
                        rightDish = dish
                    }
                }
            }
        }
        return rightDish
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecDish", for: indexPath) as! FullDescCViCell
        //print(recDish)
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        cell.displayDish(dish: findRecDish(topping: Int(recDish[indexPath.row])!))
        return cell
    }
    
}

