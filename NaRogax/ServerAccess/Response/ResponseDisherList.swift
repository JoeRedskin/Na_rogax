//
//  DishModel.swift
//  NaRogax
//
//  Created by User on 22/02/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//
import Foundation
import UIKit

struct ResponseDishesList: Decodable{
    let categories: [Categories]
    enum CodingKeys: String, CodingKey {
        case categories
    }
}

struct Categories: Decodable {
    var categoryID: Int = -1
    var categoryName: String = ""
    var categoryDishes: [DishDescription] = []
    
    enum CodingKeys: String, CodingKey{
        case categoryID = "category_id"
        case categoryName = "category_name"
        case categoryDishes = "category_dishes"
    }
}

struct DishDescription: Decodable {
    var className: String = ""
    var itemID: Int = 0
    var name: String = ""
    var price: Int? = 0
    var photo: String? = ""
    var shortDescription: String? = ""
    var longDescription: String? = ""
    var weight: String? = ""
    var recommendedDish: String? = nil
    var delivery: Bool? = false
    var subMenu: [SubMenu]? = []
    
    private enum CodingKeys: String, CodingKey{
        case className = "class_name"
        case itemID = "item_id"
        case name = "name"
        case price = "price"
        case photo = "photo"
        case shortDescription = "desc_short"
        case longDescription = "desc_long"
        case weight = "weight"
        case recommendedDish = "recommended"
        case delivery = "delivery"
        case subMenu = "sub_menu"
    }
}

struct SubMenu: Decodable {
    var parentName: String? = ""
    var name: String? = ""
    var weight: String? = ""
    var price: Int? = 0
    
    private enum CodingKeys: String, CodingKey{
        case parentName = "parent_name"
        case name
        case weight
        case price
    }
}
