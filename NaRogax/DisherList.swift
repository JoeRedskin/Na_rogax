//
//  DishModel.swift
//  NaRogax
//
//  Created by User on 22/02/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//
import Foundation
import UIKit

struct DishesList: Decodable{
    
    let categories: [Categories]
    enum CodingKeys: String, CodingKey {
        case categories
        
    }
}

struct Categories: Decodable {
    var cat_id: Int
    var cat_name: String
    var cat_dishes: [DishDescription]
    
    enum CodingKeys: String, CodingKey{
        case cat_id = "category_id"
        case cat_name = "category_name"
        case cat_dishes = "category_dishes"
    }
}

struct DishDescription: Decodable {
    
    private enum CodingKeys: String, CodingKey{
        case class_name = "class_name"
        case itemId = "item_id"
        case name = "name"
        case price = "price"
        case photo = "photo"
        case shortDescription = "desc_short"
        case longDescription = "desc_long"
        case weight = "weight"
        case recommendedWith = "recommended"
    }
    
    var class_name: String = ""
    var itemId: Int = 0
    var name: String = ""
    var price: Int? = 0
    var photo: String = ""
    var shortDescription: String = ""
    var longDescription: String = ""
    var weight: String = ""
    var recommendedWith: String?
    
}

