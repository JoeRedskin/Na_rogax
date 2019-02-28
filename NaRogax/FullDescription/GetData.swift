//
//  NewData.swift
//  NaRogax
//
//  Created by User on 26/02/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//
///
/// Don't used
///



//import Foundation
//import UIKit
//
//class GetData{
//
//    func Dishes(dataHandler: @escaping ([ListOfDishes])->()) {
//        var dishes = [ListOfDishes]()
//        guard let dishCategoryURL = URL(string: "https://na-rogah-api.herokuapp.com/get_all_items") else {
//                return}
//        let task = URLSession.shared.dataTask(with: dishCategoryURL){ (data, response, error) -> Void in
//            guard let dataResponse = data,
//                error == nil else{
//                    print(error?.localizedDescription ?? "Response Error")
//                    return}
//            do{
//                let decoder = JSONDecoder()
//                let model = try decoder.decode(ListOfDishes.self, from: dataResponse)
//                dishes.append(model)
//            } catch let parsingError {
//                print("Error", parsingError)
//            }
//            OperationQueue.main.addOperation {
//                dataHandler(dishes)
//            }
//        }
//        task.resume()
//    }
//}
