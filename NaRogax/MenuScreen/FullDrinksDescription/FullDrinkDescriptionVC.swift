//
//  FullDrinkDescriptionVC.swift
//  NaRogax
//
//  Created by User on 07/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class FullDrinkDescriptionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var drinksDescriptionScrollView: UIScrollView!
    @IBOutlet weak var drinksDescriptionBackgroundView: UIView!
    @IBOutlet weak var drinksDescriptionTableView: UITableView!
    @IBOutlet weak var drinksDescriptionImageView: UIImageView!
    @IBOutlet weak var drinksDescriptionNameLabel: UILabel!
    @IBOutlet weak var drinksDescriptionSpinner: UIActivityIndicatorView!
    
    var drinksDescription = DishDescription()
    var drinksArray: [SubMenu] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return drinksArray.count
    }
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0..<drinksArray.count:
                let cell = drinksDescriptionTableView.dequeueReusableCell(
                    withIdentifier: "DrinkCell", for: indexPath) as! DrinkDescriptionCell
                let drinksName = "\(drinksArray[indexPath.row].name ?? ""), " +
                                 "\(drinksArray[indexPath.row].weight ?? "") мл"
                cell.displayDish(name: drinksName, price: String(drinksArray[indexPath.row].price!))
                return cell
            default:
                break
        }
        return UITableViewCell()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        backButton.title = "Меню"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        GetValuesInView(menu: drinksDescription)
        drinksDescriptionTableView.delegate = self
        drinksDescriptionTableView.dataSource = self
        
        if let subDrinks = drinksDescription.sub_menu{
            drinksArray = subDrinks
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func GetValuesInView(menu: DishDescription){
        
        if menu.name == ""{
            drinksDescriptionNameLabel.text = "Без наимменования"
        } else {
            drinksDescriptionNameLabel.text = menu.name
        }
        
        if menu.photo == "" || menu.photo == nil{
            drinksDescriptionImageView.image = UIImage(named: "no_image")
        } else {
            fetchImage(url_img: menu.photo!)
        }
    }
    
    func fetchImage(url_img: String) {
        if let url = URL(string: url_img){
            drinksDescriptionSpinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents {
                        self?.drinksDescriptionImageView.image = UIImage(data: imageData)
                        self?.drinksDescriptionSpinner.stopAnimating()
                    }
                }
            }
        }
    }
}
