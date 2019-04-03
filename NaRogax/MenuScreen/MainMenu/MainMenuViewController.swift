//
//  ViewController.swift
//  NaRogax
//
//  Created by User on 20/02/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//
import UIKit

class MainMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var DishTableView: UITableView!
    
    var pageIndex: Int = 0
    var dishes = ResponseDishesList(categories: [])
    
    let cellSpacingHeight: CGFloat = 8
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if dishes.categories[pageIndex].categoryDishes.count == 0 {
            return 0
        } else {
            return dishes.categories[pageIndex].categoryDishes.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DishCell", for: indexPath) as! DishTableViewCell
        cell.displayDish(dish: dishes.categories[pageIndex].categoryDishes[indexPath.section])
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // If no internet connection when select dish from table view, show alert
        if (!DataLoader.shared().testNetwork()){
            self.present(Alert.shared().noInternet(protocol: self), animated: true, completion: nil)
        } else {
            if dishes.categories[pageIndex].categoryName != "НАПИТКИ" ||
                (dishes.categories[pageIndex].categoryDishes[indexPath.section].name.contains("Пиво")) ||
                (dishes.categories[pageIndex].categoryDishes[indexPath.section].name.contains("Чай")) {
                let storyboard = UIStoryboard(name: "FullDishDescription", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "FullDishDesc") as! FullDishDescriptionVC
                vc.dishFullDescription = dishes
                vc.indexOfDish = indexPath.section
                vc.indexOfCategory = pageIndex
                navigationController?.pushViewController(vc, animated: true)
                
            } else if dishes.categories[pageIndex].categoryName == "НАПИТКИ" {
                let storyboard = UIStoryboard(name: "FullDrinksDescription", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "FullDrinkDesc") as! FullDrinkDescriptionVC
                vc.drinksDescription = dishes.categories[pageIndex].categoryDishes[indexPath.section]
                navigationController?.pushViewController(vc, animated: true)
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DishTableView.bounces = false
        self.DishTableView.reloadData()
    }
    
    // Reload view. If user tap ok button on alert with bad internet connection.
    func reloadViewFromNib() {
        self.viewDidLoad()
    }
}

extension MainMenuViewController: AlertProtocol{
    func clickButtonPositiv(status: Int) {
        self.reloadViewFromNib()
    }
    
    func clickButtonCanсel(status: Int) {}
}
