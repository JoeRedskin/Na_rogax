//
//  FullDrinkDescriptionVC.swift
//  NaRogax
//
//  Created by User on 07/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class FullDrinkDescriptionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var ImageBGView: UIView!
    @IBOutlet weak var DrinksTableView: UITableView!
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var dishFull: [DishesList] = []
    var indexOfDish = 0
    var indexOfCategory = 0
    var drinksArr: [String] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinksArr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            
            let cell = DrinksTableView.dequeueReusableCell(withIdentifier: "DrinkCell", for: indexPath) as! DrinkDescCell

        cell.displayDish(dish: drinksArr[indexPath.row] + ", " + dishFull[0].categories[indexOfCategory].cat_dishes[indexOfDish].weight + " мл")
            
            
            return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetValuesInView(menu: dishFull[0].categories[indexOfCategory].cat_dishes[indexOfDish])
        drinksArr = dishFull[0].categories[indexOfCategory].cat_dishes[indexOfDish].longDescription.components(separatedBy: ", ")
        DrinksTableView.delegate = self
        DrinksTableView.dataSource = self
        ImageBGView.layer.cornerRadius = CGFloat(16)
        ImageBGView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.9793184433)
        //DrinksTableView.reloadData()
    }
    
    func GetValuesInView(menu: DishDescription){
        
        if menu.name == ""{
            nameField.text = "Без наимменования"
        } else if menu.name == "Соки" {
            nameField.text = "Сок"
        } else {
            nameField.text = menu.name
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
    

}
