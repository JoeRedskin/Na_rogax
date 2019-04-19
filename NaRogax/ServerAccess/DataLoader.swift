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
    private let REQUEST_CHECK_AUTH = "check_auth"
    private let REQUEST_SHOW_USER_BOOKING = "show_user_booking"
    private let REQUEST_DELETE_USER_BOOKING = "delete_user_booking/"
    private let REQUEST_FIND_USER = "find_user/"
    private let REQUEST_CHANGE_USER_CREDENTIALS = "change_user_credentials"
    private let REQUEST_VIEW_USER_CREDENTIALS = "view_user_credentials"
    
    private var access_token = ""{
        didSet{
            saveAccessToken()
        }
    }
    private static var uniqueInstance: DataLoader?
    
    
    private init() {
        loadAccessToken()
    }
    
    static func shared() -> DataLoader {
        if uniqueInstance == nil {
            uniqueInstance = DataLoader()
        }
        return uniqueInstance!
    }
    
    func exitLogin(){
        access_token = ""
        UserDefaultsData.shared().saveName(name: "")
        UserDefaultsData.shared().savePhone(phone: "")
        UserDefaultsData.shared().saveEmail(email: "")
        UserDefaultsData.shared().saveBirthDate(birthDate: "")
    }
    
    private func loadAccessToken(){
        let email = UserDefaultsData.shared().getEmail()
        if !email.isEmpty{
            access_token = KeychainService.token(service: "TokenService", account: email)
        }
        print("Token load", email)
        print("Token load", access_token)
    }
    
    private func saveAccessToken(){
        let email = UserDefaultsData.shared().getEmail()
        print("Token save ", email)
        print("Token save", access_token)
        if !email.isEmpty{
            KeychainService.setToken(access_token, service: "TokenService", account: email)
        }
    }
    
    
    func viewUserCredentials(completion:@escaping ((_ result: ResponseUserCredentials,_ error: ErrorResponse?) -> Void)) {
        var userCredentials = ResponseUserCredentials(data: DataResponse(email: "", birthday: "", name: "", phone: "", reg_date: ""))
        let headers = ["Authorization": access_token,
                       "Content-Type": "application/json"]
        Alamofire.request(SERVER_URL + REQUEST_VIEW_USER_CREDENTIALS,
                          method: .get,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .validate()
            .responseData { response in
                var errResp = ErrorResponse(code: 200,desc: "")
                switch response.result {
                case .success:
                    if let data = response.data{
                        do{
                            let decoder = JSONDecoder()
                            userCredentials = try decoder.decode(ResponseUserCredentials.self, from: data)
                        } catch _ {
                            errResp.code = response.response?.statusCode ?? 500
                            errResp.desc = ""
                        }
                    }
                case .failure(_):
                    if let data = response.data{
                        errResp = self.decodeErrResponse(data: data, code: (response.response?.statusCode)!)
                    }
                }
                OperationQueue.main.addOperation {
                    completion(userCredentials, errResp)
                }
        }
    }
    
    
    func changeUserCredentials(data: RequestChangeUserCredentials,
                               completion:@escaping ((_ result: ResponseChangeUserCredentials,_ error: ErrorResponse?) -> Void)) {
        var changeUserCredentials = ResponseChangeUserCredentials(code: 0, desc: "", email: "", access_token: "")
        let paramet = data.conventParameters()
        let headers = ["Authorization": access_token,
                       "Content-Type": "application/json"]
        Alamofire.request(SERVER_URL + REQUEST_CHANGE_USER_CREDENTIALS,
                          method: .patch,
                          parameters: paramet,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .validate()
            .responseData { response in
                var errResp = ErrorResponse(code: 200,desc: "")
                switch response.result {
                case .success:
                    if let data = response.data{
                        do{
                            let decoder = JSONDecoder()
                            changeUserCredentials = try decoder.decode(ResponseChangeUserCredentials.self, from: data)
                            if (changeUserCredentials.access_token != nil){
                                self.access_token = changeUserCredentials.access_token!
                            }
                        } catch let error {
                            print(error)
                            errResp.code = 500
                            errResp.desc = ""
                        }
                    }
                case .failure(_):
                    if let data = response.data{
                        errResp = self.decodeErrResponse(data: data, code: (response.response?.statusCode)!)
                    }
                }
                OperationQueue.main.addOperation {
                    completion(changeUserCredentials, errResp)
                }
        }
    }
    
    func showUserBooking(completion:@escaping ((_ result: ResponseShowUserBooking,_ error: ErrorResponse?) -> Void)){
        var showBooking = ResponseShowUserBooking()
        let headers = ["Authorization": access_token,
                       "Content-Type": "application/json"]
        Alamofire.request(SERVER_URL + REQUEST_SHOW_USER_BOOKING,
                          method: .get,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .validate()
            .responseData { response in
                var errResp = ErrorResponse(code: 200,desc: "")
                switch response.result {
                case .success:
                    if let data = response.data{
                        do{
                            let decoder = JSONDecoder()
                            showBooking = try decoder.decode(ResponseShowUserBooking.self, from: data)
                        } catch let error {
                            print("Booking", error)
                            errResp.code = 500
                            errResp.desc = ""
                        }
                    }
                case .failure(_):
                    if let data = response.data{
                        errResp = self.decodeErrResponse(data: data, code: (response.response?.statusCode)!)
                    }
                }
                OperationQueue.main.addOperation {
                    completion(showBooking, errResp)
                }
        }
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
                    errResp = self.decodeErrResponse(data: data, code: (response.response?.statusCode)!)
                }
            }
            print(errResp)
            OperationQueue.main.addOperation {
                completion(category, errResp)
            }
        }
    }
    
    
    //@escaping ([DishesList]) -> ()
    func getDishes(completion:@escaping ((_ result: ResponseDishesList,_ error: ErrorResponse?) -> Void)){
        var dishes = ResponseDishesList(categories: [])
        Alamofire.request(SERVER_URL + REQUEST_DISHES, method: .get)
            .validate()
            .responseData { response in
            var errResp = ErrorResponse(code: 200,desc: "")
            switch response.result {
            case .success:
                if let data = response.data{
                    do{
                        let decoder = JSONDecoder()
                        dishes = try decoder.decode(ResponseDishesList.self, from: data)
                    } catch let error {
                        print(error)
                        errResp.code = 500
                        errResp.desc = ""
                    }
                }
            case .failure(_):
                if let data = response.data{
                    errResp = self.decodeErrResponse(data: data, code: (response.response?.statusCode)!)
                }
            }
            print(errResp)
            OperationQueue.main.addOperation {
                completion(dishes, errResp)
            }
        }
    }
    
    private func decodeErrResponse(data: Data, code: Int) -> ErrorResponse{
        do{
            let decoder = JSONDecoder()
            return try decoder.decode(ErrorResponse.self, from: data)
            //print("Alamofire", model)
        } catch let error {
            print(error)
            return ErrorResponse(code: code,desc: "")
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
                        errResp = self.decodeErrResponse(data: data, code: (response.response?.statusCode)!)
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
                        errResp = self.decodeErrResponse(data: data, code: (response.response?.statusCode)!)
                    }
                }
                OperationQueue.main.addOperation {
                    completion(timetable, errResp)
                }
        }
    }
    
    func authorizeUser(data: RequestPostAuth,
                       completion:@escaping ((_ result: ResponseAuthorizeUser,_ error: ErrorResponse?) -> Void)){
        var credentals = ResponseAuthorizeUser()
        let paramet = data.conventParameters()
        print("Token authorizeUser", paramet)
        Alamofire.request(SERVER_URL + REQUEST_AUTH,
                          method: .post,
                          parameters: paramet,
                          encoding: JSONEncoding.default)
            .validate()
            .responseData { response in
                var errResp = ErrorResponse(code: 200,desc: "")
                switch response.result {
                case .success:
                    if let data = response.data{
                        do{
                            let decoder = JSONDecoder()
                            credentals = try decoder.decode(ResponseAuthorizeUser.self, from: data)
                            self.access_token = credentals.access_token
                            print("Token authorizeUser", self.access_token)
                        } catch _ {
                            errResp.code = 500
                            errResp.desc = ""
                        }
                    }
                case .failure(_):
                    if let data = response.data{
                        errResp = self.decodeErrResponse(data: data, code: (response.response?.statusCode)!)
                    }
                }
                OperationQueue.main.addOperation {
                    completion(credentals, errResp)
                }
        }
    }
    
    
    func checkAuto(completion:@escaping ((_ result: ErrorResponse?) -> Void)){
        var respData = ErrorResponse(code: 401,desc: "")
        let headers = ["Authorization": access_token]
        print("Token checkAuto", access_token)
        Alamofire.request(SERVER_URL + REQUEST_CHECK_AUTH, method: .get,
                          encoding: JSONEncoding.default,
                          headers: headers)
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
                        respData = self.decodeErrResponse(data: data, code: (response.response?.statusCode)!)
                    }
                }
                OperationQueue.main.addOperation {
                    completion(respData)
                }
        }
    }
    
    
    func userDeleteUserBooking(data: RequestPostDeleteUserBooking,
                               completion:@escaping ((_ result: ErrorResponse?) -> Void)){
        var respData = ErrorResponse(code: 200,desc: "")
        let headers = ["Authorization": access_token,
                       "Content-Type": "application/json"]
        Alamofire.request(SERVER_URL + REQUEST_DELETE_USER_BOOKING + String(data.booking_id),
                          method: .delete,
                          encoding: JSONEncoding.default,
                          headers: headers)
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
                        respData = self.decodeErrResponse(data: data, code: (response.response?.statusCode)!)
                    }
                }
                OperationQueue.main.addOperation {
                    completion(respData)
                }
        }
    }
    
    //общий метод для отправки на сервер когда ответ с сервера является ErrorResponse
    private func postToServer(parameters: Parameters, auto: Bool = false, request: String, completion:@escaping ((_ result: ErrorResponse?) -> Void)){
        var respData = ErrorResponse(code: 200,desc: "")
        var headers: [String: String]? = nil
        if (auto){
            headers = ["Authorization": access_token,
                       "Content-Type": "application/json"]
        }else{
            headers = ["Content-Type": "application/json"]
        }
        Alamofire.request(SERVER_URL + request,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: headers!)
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
                        respData = self.decodeErrResponse(data: data, code: (response.response?.statusCode)!)
                    }
                }
                completion(respData)
        }
    }
    
    func verifyEmail(data: RequestUserEmail,
                     completion:@escaping ((_ result: ErrorResponse?) -> Void)){
        let parameters = data.conventParameters()
        postToServer(parameters: parameters, request: REQUEST_VERIFY_EMAIL){ result in
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
    }
    
    func regUser(data: RequestPostRegUser,
                 completion:@escaping ((_ result: ResponseRegUser?, _ error: ErrorResponse?) -> Void)){
        let parameters = data.conventParameters()
        var respData = ErrorResponse(code: 200,desc: "")
        var result = ResponseRegUser(code: 0, desc: "", access_token: "", email: "")
        let headers = ["Authorization": access_token,
                       "Content-Type": "application/json"]
        Alamofire.request(SERVER_URL + REQUEST_REG_USER,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    if let data = response.data{
                        do{
                            let decoder = JSONDecoder()
                            result = try decoder.decode(ResponseRegUser.self, from: data)
                            self.access_token = result.access_token
                            UserDefaultsData.shared().saveEmail(email: result.email)
                        } catch _ {
                            respData.code = 500
                            respData.desc = ""
                        }
                    }
                case .failure(_):
                    if let data = response.data{
                        respData = self.decodeErrResponse(data: data, code: (response.response?.statusCode)!)
                    }
                }
                completion(result, respData)
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
        postToServer(parameters: parameters, auto: true, request: REQUEST_RESERVE_PLACE){ result in
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
    }
    
    func findUser(email: String,
                  completion:@escaping ((_ result: ErrorResponse?) -> Void)) {
        Alamofire.request(SERVER_URL + REQUEST_FIND_USER + email)
            .validate()
            .responseData { response in
                var errResp = ErrorResponse(code: 200,desc: "")
                switch response.result {
                case .success:
                    if let data = response.data{
                        do{
                            let decoder = JSONDecoder()
                            errResp = try decoder.decode(ErrorResponse.self, from: data)
                        } catch _ {
                            errResp.code = 500
                            errResp.desc = ""
                        }
                    }
                case .failure(_):
                    if let data = response.data{
                        errResp = self.decodeErrResponse(data: data, code: (response.response?.statusCode)!)
                    }
                }
                OperationQueue.main.addOperation {
                    completion(errResp)
                }
        }
    }
    
    
    func testNetwork() -> Bool{
        return Reachability.isConnectedToNetwork()
    }
}
