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
    var dishes: [DishesList] = []
    
    let cellSpacingHeight: CGFloat = 8
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if dishes.count == 0{
            //print(dishes.count)
            return 0
        }
        else{
            //print(dishes[0].categories[pageIndex].cat_dishes.count)
            return dishes[0].categories[pageIndex].cat_dishes.count
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
            //        print("****************")
            //        print(indexPath.row)
            //        print("****************")
            cell.displayDish(dish: dishes[0].categories[pageIndex].cat_dishes[indexPath.section])

            return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
         If no internet connection when select dish from table view, show alert
         */
        if (!Reachability.isConnectedToNetwork()){
            let alert = UIAlertController(title: "", message: "Проверьте интернет соединение", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default, handler: nil))
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true, completion: nil)
            })
        } else {
            if (dishes[0].categories[pageIndex].cat_name != "Топинги" && dishes[0].categories[pageIndex].cat_name != "Напитки") || (dishes[0].categories[pageIndex].cat_dishes[indexPath.section].name.contains("Пиво")) {

                let storyboard = UIStoryboard(name: "FullDishDescription", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "FullDishDesc") as! FullDishDescriptionVC
                vc.dishFull = dishes
                vc.indexOfDish = indexPath.section
                vc.indexOfCategory = pageIndex
        
                navigationController?.pushViewController(vc, animated: true)
            } else if dishes[0].categories[pageIndex].cat_name == "Напитки" {
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
        //DishTableView.bounces = false
       // DishTableView.alwaysBounceVertical = false
        /*
         If no internet connection when view did load, show alert and reload view
         */
        if (!Reachability.isConnectedToNetwork()){
            let alert = UIAlertController(title: "", message: "Проверьте интернет соединение", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default, handler: { action in
                self.reloadViewFromNib()
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let dataLoader = DataLoader()
            dataLoader.getDishes{ items in self.dishes.append(contentsOf: items)
                self.DishTableView.reloadData()

                /*
                 If no dishes from server show alert and reload view
                 */
                if (self.dishes.count) < 1 {
                    let alert = UIAlertController(title: "", message: "К сожалению мы не смогли загрузить блюда, попробуйте позже", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default, handler: { action in
                        self.reloadViewFromNib()
                    }))
                    DispatchQueue.main.async(execute: {
                        self.present(alert, animated: true, completion: nil)
                    })
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
