//
//  RecomendTableViewCell.swift
//  NaRogax
//
//  Created by User on 09/04/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class RecomendTableViewCell: UITableViewCell {

    @IBOutlet weak var recomendCollectionView: UICollectionView!
    private var recommendedDishes = [DishDescription]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        recomendCollectionView.delegate = self
        recomendCollectionView.dataSource = self
    }
    
    func setData(recommended: [DishDescription]){
        recommendedDishes = recommended
        recomendCollectionView.reloadData()
    }
}

extension RecomendTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedDishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecDish", for: indexPath) as! RecommendedDishCVC
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        cell.displayDish(dish: recommendedDishes[indexPath.row])
        return cell
    }
}
