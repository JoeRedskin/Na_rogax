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
    private let REQUEST_DISHES = "menu_by_classes"
    private let REQUEST_EMPTY_PLACES = "empty_places"
    private let REQUEST_RESERVE_PLACE = "reserve_place"
    private let REQUEST_TIMETABLE = "timetable"
    private let REQUEST_VERIFY_EMAIL = "verify_email"
    private let REQUEST_REG_USER = "reg_user"
    private let REQUEST_AUTH = "auth"
    private let REQUEST_PASSWORD_RECOVERY = "password_recovery"
    private let REQUEST_CATEGORY = "categories"
    
    private static var uniqueInstance: DataLoader?
    
    private init() {}
    
    static func shared() -> DataLoader {
        if uniqueInstance == nil {
            uniqueInstance = DataLoader()
        }
        return uniqueInstance!
    }
    
    func getCategories(completion:@escaping ((_ result: ResponseCategory,_ error: ErrorResponse?) -> Void)){
        var category = ResponseCategory(categories: [])
        Alamofire.request(SERVER_URL + REQUEST_CATEGORY, method: .get).validate().responseData { response in
            var errResp = ErrorResponse(code: 200,desc: "")
            switch response.result {
            case .success:
                if let data = response.data{
                    do{
                        let decoder = JSONDecoder()
                        category = try decoder.decode(ResponseCategory.self, from: data)
                    } catch _ {
                        errResp.code = 500
                        errResp.desc = ""
                    }
                }
            case .failure(_):
                if let data = response.data{
                    errResp = self.decodeErrResponse(data: data)
                }
            }
            OperationQueue.main.addOperation {
                completion(category, errResp)
            }
        }
    }
    
    
    //@escaping ([DishesList]) -> ()
    func getDishes(completion:@escaping ((_ result: ResponseDishesList,_ error: ErrorResponse?) -> Void)){
        var dishes = ResponseDishesList(categories: [])
        Alamofire.request(SERVER_URL + REQUEST_DISHES, method: .get).validate().responseData { response in
            var errResp = ErrorResponse(code: 200,desc: "")
            switch response.result {
            case .success:
                if let data = response.data{
                    do{
                        let decoder = JSONDecoder()
                        dishes = try decoder.decode(ResponseDishesList.self, from: data)
                    } catch _ {
                        errResp.code = 500
                        errResp.desc = ""
                    }
                }
            case .failure(_):
                if let data = response.data{
                    errResp = self.decodeErrResponse(data: data)
                }
            }
            OperationQueue.main.addOperation {
                completion(dishes, errResp)
            }
        }
    }
    
    private func decodeErrResponse(data: Data) -> ErrorResponse{
        do{
            //print("dataResponse", data.re)
            let decoder = JSONDecoder()
            return try decoder.decode(ErrorResponse.self, from: data)
            //print("Alamofire", model)
        } catch _ {
            return ErrorResponse(code: 500,desc: "")
        }
    }
    
    func getEmptyTables(data: RequestPostEmptyPlaces,
                        completion:@escaping ((_ result: ResponseTablesList,_ error: ErrorResponse?) -> Void)) {
        var tables = ResponseTablesList(data: [])
        let paramet = data.conventParameters()
        Alamofire.request(SERVER_URL + REQUEST_EMPTY_PLACES, method: .post, parameters: paramet, encoding: JSONEncoding.default)
            .validate()
            .responseData { response in
                var errResp = ErrorResponse(code: 200,desc: "")
                switch response.result {
                case .success:
                    if let data = response.data{
                        do{
                            let decoder = JSONDecoder()
                            tables = try decoder.decode(ResponseTablesList.self, from: data)
                        } catch _ {
                            errResp.code = 500
                            errResp.desc = ""
                        }
                    }
                case .failure(_):
                    if let data = response.data{
                        errResp = self.decodeErrResponse(data: data)
                    }
                }
                OperationQueue.main.addOperation {
                    completion(tables, errResp)
                }
            }
    }
    
    func getTimetable(completion:@escaping ((_ result: ResponseTimetable,_ error: ErrorResponse?) -> Void)){
        var timetable = ResponseTimetable(data: [])
        //TO DO: edit link. Put pageIdvalue  instead of categoryId.
        Alamofire.request(SERVER_URL + REQUEST_TIMETABLE)
            .validate()
            .responseData { response in
                var errResp = ErrorResponse(code: 200,desc: "")
                switch response.result {
                case .success:
                    if let data = response.data{
                        do{
                            let decoder = JSONDecoder()
                            timetable = try decoder.decode(ResponseTimetable.self, from: data)
                        } catch _ {
                            errResp.code = 500
                            errResp.desc = ""
                        }
                    }
                case .failure(_):
                    if let data = response.data{
                        errResp = self.decodeErrResponse(data: data)
                    }
                }
                OperationQueue.main.addOperation {
                    completion(timetable, errResp)
                }
        }
    }
    
    func authorizeUser(data: RequestPostAuth,
                       completion:@escaping ((_ result: ResponseAuthorizeUser,_ error: ErrorResponse?) -> Void)){
        var auth = ResponseAuthorizeUser()
        let paramet = data.conventParameters()
        Alamofire.request(SERVER_URL + REQUEST_AUTH, method: .post, parameters: paramet, encoding: JSONEncoding.default)
            .validate()
            .responseData { response in
                var errResp = ErrorResponse(code: 200,desc: "")
                switch response.result {
                case .success:
                    if let data = response.data{
                        do{
                            let decoder = JSONDecoder()
                            auth = try decoder.decode(ResponseAuthorizeUser.self, from: data)
                        } catch _ {
                            errResp.code = 500
                            errResp.desc = ""
                        }
                    }
                case .failure(_):
                    if let data = response.data{
                        errResp = self.decodeErrResponse(data: data)
                    }
                }
                OperationQueue.main.addOperation {
                    completion(auth, errResp)
                }
        }
    }
    
    //общий метод для отправки на сервер когда ответ с сервера является ErrorResponse
    private func postToServer(parameters: Parameters, request: String, completion:@escaping ((_ result: ErrorResponse?) -> Void)){
        var respData = ErrorResponse(code: 200,desc: "")
        Alamofire.request(SERVER_URL + request, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    if let data = response.data{
                        do{
                            let decoder = JSONDecoder()
                            respData = try decoder.decode(ErrorResponse.self, from: data)
                        } catch _ {
                            respData.code = 500
                            respData.desc = ""
                        }
                    }
                case .failure(_):
                    if let data = response.data{
                        respData = self.decodeErrResponse(data: data)
                    }
                }
                completion(respData)
        }
    }
    
    
    func verifyEmail(data: RequestPostVertifyEmail,
                     completion:@escaping ((_ result: ErrorResponse?) -> Void)){
        let parameters = data.conventParameters()
        postToServer(parameters: parameters, request: REQUEST_VERIFY_EMAIL){ result in
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
    }
    
    func regUser(data: RequestPostRegUser,
                 completion:@escaping ((_ result: ErrorResponse?) -> Void)){
        let parameters = data.conventParameters()
        postToServer(parameters: parameters, request: REQUEST_REG_USER){ result in
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
    }
    
    func passwordRecovery(data: RequestPostPasswordRecovery,
                          completion:@escaping ((_ result: ErrorResponse?) -> Void)){
        let parameters = data.conventParameters()
        postToServer(parameters: parameters, request: REQUEST_PASSWORD_RECOVERY){ result in
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
    }
    
    func reserveTable(data: RequestPostReservePlace,
                      completion:@escaping ((_ result: ErrorResponse?) -> Void)) {
        let parameters = data.conventParameters()
        postToServer(parameters: parameters, request: REQUEST_RESERVE_PLACE){ result in
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
    }
    
    func testNetwork() -> Bool{
        return Reachability.isConnectedToNetwork()
    }
}
