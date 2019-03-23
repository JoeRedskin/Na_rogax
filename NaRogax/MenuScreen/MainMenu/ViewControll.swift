//
//  ViewController.swift
//  NaRogax
//
//  Created by User on 20/02/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var DishTableView: UITableView!
    var pageIndex: Int = 0
    var dishes = ResponseDishesList(categories: [])
    
    let cellSpacingHeight: CGFloat = 8
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if dishes.categories.count == 0{
            //print(dishes.count)
            return 0
        }
        else{
            //print(dishes[0].categories[pageIndex].cat_dishes.count)
            return dishes.categories[pageIndex].cat_dishes.count
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
        cell.displayDish(dish: dishes.categories[pageIndex].cat_dishes[indexPath.section])
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
         If no internet connection when select dish from table view, show alert
         */
        if (!DataLoader.shared().testNetwork()){
            self.present(Alert.shared().noInternet(protocol: self), animated: true, completion: nil)
        } else {
            if (dishes.categories[pageIndex].cat_name != "ТОПИНГИ" && dishes.categories[pageIndex].cat_name != "НАПИТКИ") || (dishes.categories[pageIndex].cat_dishes[indexPath.section].name.contains("Пиво")) || (dishes.categories[pageIndex].cat_dishes[indexPath.section].name.contains("Сок")) || (dishes.categories[pageIndex].cat_dishes[indexPath.section].name.contains("Лимонад")){
                //                print("Rec: \(String(describing: dishes[0].categories[pageIndex].cat_dishes[indexPath.row].recommendedWith))")
                //let storyboard = UIStoryboard(name: "FullDescription", bundle: nil)
                //let vc = storyboard.instantiateViewController(withIdentifier: "FullDesc") as! FullDescriptionVC
                let storyboard = UIStoryboard(name: "FullDishDescription", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "FullDishDesc") as! FullDishDescriptionVC
                vc.dishFull = dishes
                vc.indexOfDish = indexPath.section
                vc.indexOfCategory = pageIndex
                
                navigationController?.pushViewController(vc, animated: true)
            } else if dishes.categories[pageIndex].cat_name == "НАПИТКИ" {
                let storyboard = UIStoryboard(name: "FullDrinksDescription", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "FullDrinkDesc") as! FullDrinkDescriptionVC
                
                vc.dishFull = dishes
                vc.indexOfDish = indexPath.section
                vc.indexOfCategory = pageIndex
                
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //DishTableView.delegate = self
        //DishTableView.dataSource = self
        /* Disable streching on table view */
        DishTableView.bounces = false
        // DishTableView.alwaysBounceVertical = false
        /*
         If no internet connection when view did load, show alert and reload view
         */
        
        if (!DataLoader.shared().testNetwork()){
            self.present(Alert.shared().noInternet(protocol: self), animated: true, completion: nil)
        } else {
            DataLoader.shared().getDishes(){ result, error in
                if error?.code == 200{
                    self.dishes = result
                    self.DishTableView.reloadData()
                }else{
                    self.present(Alert.shared().couldServerDown(protocol: self), animated: true, completion: nil)
                }
            }
        }
    }
    
    
    /*
     Reload view. If user tap ok button on alert with bad internet connection.
     */
    func reloadViewFromNib() {
        self.viewDidLoad()
    }
}


extension ViewController: AlertProtocol{
    func clickButtonPositiv(status: Int) {
        self.reloadViewFromNib()
    }
    func clickButtonCanсel(status: Int) {}
}
