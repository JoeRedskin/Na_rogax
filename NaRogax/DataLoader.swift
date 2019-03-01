//
//  DateLoader.swift
//  NaRogax
//
//  Created by User on 22/02/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation

class DataLoader{
    

//     func getDishCategories(completion: @escaping ([Categotries]) -> ()) {
//        var categories = [Categotries]()
//         guard let dishCategoryURL = URL(string: "https://na-rogah-api.herokuapp.com/get_classes") else {return}
//         let task = URLSession.shared.dataTask(with: dishCategoryURL){ (data, response, error) -> Void in
//             guard let dataResponse = data,
//                error == nil else{
//                    print(error?.localizedDescription ?? "Response Error")
//                    return}
//             do{
//                 let categoriesResponse = try JSONDecoder().decode(Categotries.self, from: dataResponse)
//                 categories.append(categoriesResponse)
//                 print (categoriesResponse)
//             } catch let parsingError {
//                print("Error:", parsingError)
//             }
//            OperationQueue.main.addOperation {
//                completion(categories)
//            }
//         }
//         task.resume()
//     }
    
    func getDishes(completion: @escaping ([DishesList]) -> ()){
        
        var dishes = [DishesList]()
        //TO DO: edit link. Put pageIdvalue  instead of categoryId.
        
        guard let dishCategoryURL = URL(string: "https://na-rogah-api.herokuapp.com/get_menu_by_classes") else {return}
        let task = URLSession.shared.dataTask(with: dishCategoryURL){  (data, response, error) -> Void in
            guard let dataResponse = data,
                error == nil else{
                    print(error?.localizedDescription ?? "Response Error")
                    return}
            do{
                let decoder = JSONDecoder()
                let model = try decoder.decode(DishesList.self, from: dataResponse)
                dishes.append(model)
                //print(model)
            } catch let parsingError {
                print("Error", parsingError)
            }
            OperationQueue.main.addOperation {
                completion(dishes)
            }
        }
        task.resume()
    }
}

/*

 extension DishesList{
 
 private enum TopCodingKeys: String, CodingKey {
 case menu
 }
 
 init(from decoder: Decoder) throws {
 let container = try decoder.container(keyedBy: TopCodingKeys.self)
 let meta = try container.nestedContainer(keyedBy: TopCodingKeys.self, forKey: .menu)
 var menuContainer = try meta.nestedUnkeyedContainer(forKey: .menu)
 var dishes: [Dish] = []
 while !menuContainer.isAtEnd {
 let dish = try menuContainer.decode(Dish.self)
 dishes.append(dish)
 }
 self.init(menu: dishes)
 }
 
 /*
 let meta  = try container.nestedUnkeyedContainer(forKey: .menu)
 let dishes = try meta.decode(Dish.self, forKey: .menu)
 self.init(dish: [dishes])
 */
 /*
 self.itemId = try! container.decode(Int.self, forKey: .itemId)
 self.name = try! container.decode(String.self, forKey: .name)
 self.price = try! container.decode(Int.self, forKey: .price)
 self.photo = try! container.decode(String.self, forKey: .photo)
 self.shortDescription = try! container.decode(String.self, forKey: .shortDescription)
 self.longDescription = try! container.decode(String.self, forKey: .longDescription)
 self.weight = try! container.decode(Int.self, forKey: .weight)
 self.recommendedWith = try! container.decode([Int].self, forKey: .recommendedWith)
 }
 */
 }
 /*
 extension DishCategory{
 //private enum TopCodingKeys: String, CodingKey{
 //  case dishCategory
 //}
 init(from decoder: Decoder) throws {
 let container = try decoder.container(keyedBy: CodingKeys.self)
 self.classId = try! container.decode(Int.self, forKey: .classId)
 self.name = try! container.decode(String.self, forKey: .name)
 /*
 let meta = try container.nestedContainer(keyedBy: TopCodingKeys.self, forKey: .dishCategory)
 let categories = try meta.decode([DishCategory].self, forKey: .dishCategory)
 self.init(categories: categories)
 */
 /*
 let meta  = try container.nestedContainer(keyedBy: TopCodingKeys.self, forKey: .dishCategory)
 var blogsContainer = try meta.nestedUnkeyedContainer(forKey: .dishCategory)
 var blogs: [DishCategory] = []
 while !blogsContainer.isAtEnd {
 let blog = try blogsContainer.decode(DishCategory.self)
 blogs.append(blog)
 }
 self.init(categories: blogs) */
 }
 
 }
 */
 */
