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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dishes.count == 0{
            //print(dishes.count)
            return 0
        }
        else{
            //print(dishes[0].categories[pageIndex].cat_dishes.count)
            return dishes[0].categories[pageIndex].cat_dishes.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dishes[0].categories[pageIndex].cat_name == "Топинги" || dishes[0].categories[pageIndex].cat_name == "Напитки"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToppingCell", for: indexPath)
                as! ToppingTableViewCell
            cell.displayDish(dish: dishes[0].categories[pageIndex].cat_dishes[indexPath.row])
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DishCell", for: indexPath) as! DishTableViewCell
            //        print("****************")
            //        print(indexPath.row)
            //        print("****************")
            cell.displayDish(dish: dishes[0].categories[pageIndex].cat_dishes[indexPath.row])
            return cell
        }
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
            if dishes[0].categories[pageIndex].cat_name != "Топинги" && dishes[0].categories[pageIndex].cat_name != "Напитки"{
                let storyboard = UIStoryboard(name: "FullDescription", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "FullDesc") as! FullDescriptionVC
                vc.dishFull = dishes
                vc.indexOfDish = indexPath.row
                vc.indexOfCategory = indexPath.row
        
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        /* Disable streching on table view */
        DishTableView.bounces = false
        DishTableView.alwaysBounceVertical = false
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
