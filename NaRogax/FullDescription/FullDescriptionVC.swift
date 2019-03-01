//
//  FullDescriptionVC.swift
//  NaRogax
//
//  Created by User on 26/02/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

//TODO:
//2 Алерт проверки данных
//3 общий спиннер
//4 спиннер на картинку
//8 после скролла должна оставаться позиция в main screen
//9 скрытие навбара при скролле вниз/ появление при скролле вверх
//10 соединить с рабочим main screen


import UIKit

class FullDescriptionVC: UIViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetValuesInView(menu: dishFull[indexOfDish])
    }

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var nameField: UILabel!    
    @IBOutlet weak var desc_longField: UILabel!
    @IBOutlet weak var weightField: UILabel!
    @IBOutlet weak var priceField: UILabel!
    
    var dishFull: [DishDescription] = []
    var indexOfDish = 0
    
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
        
        if menu.weight == nil{
             weightField.isHidden = true
        } else {
            weightField.text = String(menu.weight!)+" г"
        }
        
        if menu.price == nil{
            priceField.text = "--- р"
        } else {
            priceField.text = String(menu.price!)+" р"
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
                        self?.imageField.image = UIImage(data: imageData)
                        self?.spinner.stopAnimating()
                    }
                }
            }
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if dishes[0].menu.count != nil{
//            return dishes[0].menu.count
//        } else {
//            return 0
//        }
//    }
//    @IBOutlet weak var collectionView: UICollectionView!
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Rec_dish", for: indexPath)
//        if let contenCell = cell as? FullDescCViCell{
//            if dishes[0].menu[indexPath.row].name != ""{
//                contenCell.rec_name.text = dishes[0].menu[indexPath.row].name
//            }
//        }
//        return cell
//    }
}

