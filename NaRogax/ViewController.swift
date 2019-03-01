//
//  ViewController.swift
//  NaRogax
//
//  Created by User on 20/02/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var dishCollectionView: UICollectionView!
    
    var pageIndex: Int = 0
    var pageName: String = ""
    var dishes: [DishesList] = []
    var sumOfIndex = 0
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dishes.count == 0{
            return 0
        }
        else{
            return dishes[0].categories[pageIndex].cat_dishes.count
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishCell", for: indexPath) as! DishCollectionViewCell
        print("****************")
        print(indexPath.row)
        print("****************")
            cell.displayDish(dish: dishes[0].categories[pageIndex].cat_dishes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "FullDescription", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FullDesc") as! FullDescriptionVC
        vc.dishFull = dishes[0].categories[pageIndex].cat_dishes
        vc.indexOfDish = indexPath.row

        navigationController?.pushViewController(vc, animated: true)
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        //dataLoader.getDishCategories()
        let dataLoader = DataLoader()
        dataLoader.getDishes{ items in self.dishes.append(contentsOf: items)
            self.dishCollectionView.reloadData()
            
        }
    }

}

