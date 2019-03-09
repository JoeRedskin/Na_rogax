//
//  FullDishDescriptionVC.swift
//  NaRogax
//
//  Created by User on 09/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class FullDishDescriptionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    @IBOutlet weak var ImageBGView: UIView!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var DescLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var AddToCartBtn: UIButton!
    @IBOutlet weak var WeightLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var RecomendedCollectionView: UICollectionView!
    @IBOutlet weak var AddedLabel: UILabel!
    @IBOutlet weak var MinusStepper: UIButton!
    @IBOutlet weak var CountLabel: UILabel!
    @IBOutlet weak var PlusStepper: UIButton!
    
    
    var dishFull: [DishesList] = []
    var indexOfDish = 0
    var indexOfCategory = 0
    var recDish: [String] = []
    
    var AddCount: Int = 1 {
        didSet {
            CountLabel.text = String(AddCount)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetValuesInView(menu: dishFull[0].categories[indexOfCategory].cat_dishes[indexOfDish])
        ImageBGView.layer.cornerRadius = CGFloat(16)
        ImageBGView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.9793184433)
        AddToCartBtn.layer.cornerRadius = 20
        AddToCartBtn.layer.borderWidth = 1
        AddToCartBtn.layer.borderColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
        RecomendedCollectionView.delegate = self
        RecomendedCollectionView.dataSource = self
        recStringToMassive()
        RecomendedCollectionView.reloadData()
        
        PlusStepper.layer.cornerRadius = 2
        PlusStepper.layer.borderWidth = 1
        PlusStepper.layer.borderColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
        
        MinusStepper.layer.cornerRadius = 2
        MinusStepper.layer.borderWidth = 1
        MinusStepper.layer.borderColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
    }
    
    func GetValuesInView(menu: DishDescription){
        
        if menu.name == ""{
            NameLabel.text = "Без наимменования"
        } else {
            NameLabel.text = menu.name
        }
        
        if menu.longDescription == ""{
            DescLabel.isHidden = true
        } else {
            DescLabel.text = menu.longDescription
        }
        
        if menu.weight == ""{
            WeightLabel.isHidden = true
        } else {
            WeightLabel.text = menu.weight
        }
         
         if menu.price == nil{
            PriceLabel.text = "⏤ р"
         } else {
            PriceLabel.text = String(menu.price!)+" р"
         }
        
        fetchImage(url_img: menu.photo)
        
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
        if let recDishString = dishFull[0].categories[indexOfCategory].cat_dishes[indexOfDish].recommendedWith{
            //print(recDishString)
            var str = ""
            for index in recDishString.indices{
                if (recDishString[index] >= "0" && recDishString[index] <= "9") {
                    str += String(recDishString[index])
                    if index.encodedOffset == recDishString.count-1{
                        //print(str)
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
            //if category.cat_name == "Топинги" || category.cat_name == "Напитки"{
                for dish in category.cat_dishes{
                    if dish.itemId == topping{
                        rightDish = dish
                    }
                }
            //}
        }
        return rightDish
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecDish", for: indexPath) as! RecDishCVC
        //print(recDish)
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        cell.displayDish(dish: findRecDish(topping: Int(recDish[indexPath.row])!))
        return cell
    }
        
    func changeState(active: Bool){
        AddToCartBtn.isHidden = !active
        AddedLabel.isHidden = active
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


