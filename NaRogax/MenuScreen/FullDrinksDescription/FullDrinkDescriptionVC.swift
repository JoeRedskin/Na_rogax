//
//  FullDrinkDescriptionVC.swift
//  NaRogax
//
//  Created by User on 07/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class FullDrinkDescriptionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var ImageBGView: UIView!
    @IBOutlet weak var DrinksTableView: UITableView!
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var dishFull = DishDescription()
    var drinksArr: [SubMenu] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (drinksArr.count)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            case 0..<drinksArr.count:
                let cell = DrinksTableView.dequeueReusableCell(withIdentifier: "DrinkCell", for: indexPath) as! DrinkDescCell
                var nameDish = drinksArr[indexPath.row].name ?? ""
                nameDish += ", "
                nameDish += drinksArr[indexPath.row].weight ?? "" + " мл"
                nameDish += " мл"
                cell.displayDish(dish: nameDish, price: String(drinksArr[indexPath.row].price!))
                return cell
            default:
                break
        }
        
        return UITableViewCell()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetValuesInView(menu: dishFull)
        DrinksTableView.delegate = self
        DrinksTableView.dataSource = self
        ImageBGView.clipsToBounds = true
        ImageBGView.layer.cornerRadius = CGFloat(16)
        
        print("nap", dishFull)
        if let sub = dishFull.sub_menu{
            drinksArr = sub
            print("nap", drinksArr)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func GetValuesInView(menu: DishDescription){
        
        if menu.name == ""{
            nameField.text = "Без наимменования"
        } else if menu.name == "Соки" {
            nameField.text = "Сок"
        } else {
            nameField.text = menu.name
        }
        
        if menu.photo == "" || menu.photo == nil{
            imageField.image = UIImage(named: "no_image")
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
                        self?.imageField.image = UIImage(data: imageData)
                        self?.spinner.stopAnimating()
                    }
                }
            }
        }
    }
}
