//
//  FullDescVC.swift
//  NaRogax
//
//  Created by User on 09/04/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class FullDescVC: UIViewController {

    @IBOutlet weak var mainTable: UITableView!
    
    var menu = ResponseDishesList(categories: [])
    var indexOfDish = -1
    var indexOfCategory = -1
    private var recomendDish = [DishDescription]()
    private var nameCellActive = [String]()
    private var dish = DishDescription()
    private var subMenu = [SubMenu]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTable.delegate = self
        mainTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //ImageCell
        //DescriptionCell
        //WigthPriceCell
        //EnumerationCell
        //RecomendCell
        nameCellActive.append("ImageCell")
        if menu.categories.count > 0{
            dish = menu.categories[indexOfCategory].categoryDishes[indexOfDish]
            if !(dish.longDescription?.isEmpty ?? true){
                nameCellActive.append("DescriptionCell")
            }
            if dish.subMenu?.count ?? -1 > 0{
                nameCellActive.append("EnumerationCell")
                subMenu = dish.subMenu!
            }else{
                nameCellActive.append("WigthPriceCell")
            }
            
            if dish.recommendedDish?.count ?? -1 > 0{
                nameCellActive.append("RecomendCell")
                if let arrayRec = dish.recommendedDish?.split(separator: ";"){
                    for item in arrayRec{
                        recomendDish.append(findRecommendedDishes(topping: Int(item)!))
                    }
                }
            }
        }
        mainTable.reloadData()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func findRecommendedDishes(topping: Int) -> DishDescription {
        var rightRecommendedDish = DishDescription()
        for category in menu.categories {
            for dish in category.categoryDishes {
                if dish.itemID == topping {
                    rightRecommendedDish = dish
                }
            }
        }
        return rightRecommendedDish
    }
}

extension FullDescVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameCellActive.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch nameCellActive[indexPath.row] {
        case "ImageCell":
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageDiscTableViewCell
            cell.setData(dish: dish)
            return cell
        case "DescriptionCell":
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! DescriptionTableViewCell
            cell.setData(dish: dish)
            return cell
        case "EnumerationCell":
            let cell = tableView.dequeueReusableCell(withIdentifier: "EnumerationCell", for: indexPath) as! EnumerationTableViewCell
            cell.setDate(array: subMenu, category: dish.className)
            return cell
        case "RecomendCell":
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecomendCell", for: indexPath) as! RecomendTableViewCell
            cell.setData(recommended: recomendDish)
            return cell
        case "WigthPriceCell":
            let cell = tableView.dequeueReusableCell(withIdentifier: "WigthPriceCell", for: indexPath) as! WigthPriceTableViewCell
            cell.setData(dish: dish)
            return cell
        default:
            break
        }
        return UITableViewCell()
    }

}
