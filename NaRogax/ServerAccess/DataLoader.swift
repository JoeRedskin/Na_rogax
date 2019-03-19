//
//  DateLoader.swift
//  NaRogax
//
//  Created by User on 22/02/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation
import Alamofire

class DataLoader{
    private let SERVER_URL = "https://na-rogah-api.herokuapp.com/api/v1/"
    
    func postReservePlace(post: PostReservePlace, completion:((_ result: ResponseReservePlace, _ error: Error?) -> Void)?) {
        var responseReservePlace = ResponseReservePlace(code: -1, desc: "")
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "na-rogah-api.herokuapp.com"
        urlComponents.path = "/api/v1/reserve_place"
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        
        // Specify this request as being a POST method
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // Make sure that we include headers specifying that our request's HTTP body
        // will be JSON encoded
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        // Now let's encode out Post struct into JSON data...
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(post)
            // ... and set our request's HTTP body
            request.httpBody = jsonData
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            completion?(responseReservePlace, error)
        }
        
        // Create and run a URLSession data task with our JSON encoded POST request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            //Если прилетела ошибка то выкидываем ее выше и выходим
            guard responseError == nil else {
                completion?(responseReservePlace, responseError!)
                return
            }
            //декодируем данные из json в структуру
            do{
                let decoder = JSONDecoder()
                responseReservePlace = try decoder.decode(ResponseReservePlace.self, from: responseData!)
                completion?(responseReservePlace, nil)
            } catch let parsingError {
                completion?(responseReservePlace, parsingError)
            }
        }
        task.resume()
    }
    
    
    func getDishes(completion: @escaping ([DishesList]) -> ()){
        let REQ = "menu_by_classes"
        var dishes = [DishesList]()

       /* Alamofire.request(SERVER_URL + REQ, method: .get).responseJSON { response in
            guard response.result.isSuccess else {
                print("Ошибка при запросе данных\(String(describing: response.result.error))")
                return
            }
            
            guard let arrayOfItems = response.result.value as? [[String:AnyObject]]
                else {
                    print("Не могу перевести в массив")
                    return
            }
            
            for itm in arrayOfItems {
                let item = 
                //let item = Item(albimID: itm["albumId"] as! Int, id: itm["id"] as! Int, title: itm["title"] as! String, url: itm["url"] as! String)
                //self.items.append(item)
            }
            
            OperationQueue.main.addOperation {
                completion(dishes)
            }
        }*/
        //TO DO: edit link. Put pageIdvalue  instead of categoryId.
        
        //let dishCategoryURL = Bundle.main.url(forResource: "document", withExtension: "txt")!
        guard let dishCategoryURL = URL(string: "https://na-rogah-api.herokuapp.com/api/v1/menu_by_classes") else {return}

        let task = URLSession.shared.dataTask(with: dishCategoryURL){  (data, response, error) -> Void in
            guard let dataResponse = data,
                error == nil else{
                    print(error?.localizedDescription ?? "Response Error")
                    return}
            do{
                print("dataResponse", data.re)
                let decoder = JSONDecoder()
                let model = try decoder.decode(DishesList.self, from: dataResponse)
                dishes.append(model)
                //print(model)
            } catch let parsingError {
                print("Error", parsingError)
            }

        }
        task.resume()
    }
    
    func getEmptyTables(date: ReserveDate, completion: @escaping ([TablesList]) -> ()) {
        var tables = [TablesList]()
        guard let url = URL(string: "https://na-rogah-api.herokuapp.com/api/v1/empty_places") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(date)
            request.httpBody = jsonData
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            completion(tables)
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard let dataResponse = responseData,
                responseError == nil else{
                    print(responseError?.localizedDescription ?? "Response Error")
                    return}
            do{
                let decoder = JSONDecoder()
                let model = try decoder.decode(TablesList.self, from: dataResponse)
                //dishes.append(model)
                tables.append(model)
            } catch let parsingError {
                print("Error", parsingError)
            }
            OperationQueue.main.addOperation {
                completion(tables)
            }
            
        }
        task.resume()
    }
    
    func reserveTable(data: ReserveTableData, completion: @escaping ([ReserveResponseData]) -> ()) {
        var respData = [ReserveResponseData]()
        guard let url = URL(string: "https://na-rogah-api.herokuapp.com/api/v1/reserve_place") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(data)
            request.httpBody = jsonData
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            completion(respData)
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard let dataResponse = responseData,
                responseError == nil else{
                    print(responseError?.localizedDescription ?? "Response Error")
                    return}
            do{
                let decoder = JSONDecoder()
                let model = try decoder.decode(ReserveResponseData.self, from: dataResponse)
                //dishes.append(model)
                respData.append(model)
            } catch let parsingError {
                print("Error", parsingError)
            }
            OperationQueue.main.addOperation {
                completion(respData)
            }
            
        }
        task.resume()
    }
    
    func getTimetable(completion: @escaping ([Timetable]) -> ()){
        
        var timetable = [Timetable]()
        //TO DO: edit link. Put pageIdvalue  instead of categoryId.
        
        //let dishCategoryURL = Bundle.main.url(forResource: "document", withExtension: "txt")!
        guard let dishCategoryURL = URL(string: "https://na-rogah-api.herokuapp.com/api/v1/timetable") else {return}
        
        let task = URLSession.shared.dataTask(with: dishCategoryURL){  (data, response, error) -> Void in
            guard let dataResponse = data,
                error == nil else{
                    print(error?.localizedDescription ?? "Response Error")
                    return}
            do{

                let decoder = JSONDecoder()
                let model = try decoder.decode(Timetable.self, from: dataResponse)
                timetable.append(model)

            } catch let parsingError {
                print("Error", parsingError)
            }
            OperationQueue.main.addOperation {
                completion(timetable)
            }
        }
        task.resume()
    }
}
