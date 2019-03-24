//
//  Alert.swift
//  NaRogax
//
//  Created by User on 21/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//
import Foundation
import UIKit

protocol AlertProtocol {
    func clickButtonPositiv(status: Int)
    func clickButtonCanсel(status: Int)
}

class Alert{
    //singl
    private static var uniqueInstance: Alert?
    private init() {}
    
    //Сообщения
    private let MESSEGE_NO_NETWORK = "Проверьте интернет соединение"
    private let MESSEGE_SERVER_DOWN = "Сервер недоступен, но мы уже занимаемся этой проблемой.Попробуйте позже"
    private let MESSEGE_TABLE_BUSY = "Измените время, продолжительность или дату визита и попробуйте снова."
    private let MESSEGE_CANSEL_BOOKING = "Отменить бронирование на "
    private let MESSEGE_PASSWORD_CHANGED = "Ваш пароль успешно изменен. Мы рады, что вы снова с нами."
    private let MESSEGE_ERROR_NETWORK_BOOKING = "Без подключения к сети невозможно продолжить бронирование. \nПроверьте соединение и попробуйте снова"
    
    //Титулы
    private let TITLE_SELECT_TIME = "Выберите время"
    private let TITLE_TABLE_BUSY = "Все столы заняты"
    private let TITLE_CANSEL_BOOKING = "Отмена брони"
    private let TITLE_PASSWORD_CHANGED = "Пароль изменен"
    private let TITLE_ERROR_NETWORK_BOOKING = "Ошибка соединения"
    private let TITLE_SERVER_DOWN = "Нет соединения с сервером"
    
    //Название кнопок
    private let BUTTON_MESSEGE_OK = ["Ок"]
    private let BUTTON_MESSEGE_OK_CANCEL = ["Ок", "Отмена"]
    private let BUTTON_MESSEGE_ERROR_NETWORK = ["Повторить соединение", "Отмена"]
    
    static func shared() -> Alert {
        if uniqueInstance == nil {
            uniqueInstance = Alert()
        }
        return uniqueInstance!
    }
    
    func messegeErrorNetworkBooking(status code: Int = 0, protocol prot: AlertProtocol?) -> UIAlertController {
        return createAlert(status: code, title: TITLE_ERROR_NETWORK_BOOKING,messege: MESSEGE_ERROR_NETWORK_BOOKING
            , buttonMessege: BUTTON_MESSEGE_ERROR_NETWORK, protocol: prot)
    }
    
    func couldServerDown(status code: Int = 0, protocol prot: AlertProtocol?) -> UIAlertController{
        return createAlert(status: code,title: TITLE_SERVER_DOWN, messege: MESSEGE_SERVER_DOWN, buttonMessege: BUTTON_MESSEGE_OK, protocol: prot)
    }
    
    func noInternet(status code: Int = 0, protocol prot: AlertProtocol?) -> UIAlertController{
        return createAlert(status: code, messege: MESSEGE_NO_NETWORK, buttonMessege: BUTTON_MESSEGE_OK, protocol: prot)
    }
    
    func changePassword(status code: Int = 0, protocol prot: AlertProtocol?) -> UIAlertController {
        return createAlert(status: code, title: TITLE_PASSWORD_CHANGED,messege: MESSEGE_PASSWORD_CHANGED, buttonMessege: BUTTON_MESSEGE_OK, protocol: prot)
    }
    
    func tableAraBusy(status code: Int = 0, protocol prot: AlertProtocol?) -> UIAlertController {
        return createAlert(status: code, title: TITLE_TABLE_BUSY,messege: MESSEGE_TABLE_BUSY,
                           buttonMessege: BUTTON_MESSEGE_OK_CANCEL, protocol: prot)
    }
    
    func canselBooking(status code: Int = 0, protocol prot: AlertProtocol?, time: String) -> UIAlertController {
        return createAlert(status: code, title: TITLE_CANSEL_BOOKING,
                           messege: MESSEGE_CANSEL_BOOKING + time,
                           buttonMessege: BUTTON_MESSEGE_OK_CANCEL, protocol: prot)
    }
    
    func pickerAlert(status code: Int = 0, protocol prot: AlertProtocol?, delegate: UIPickerViewDelegate,
                     dataSource: UIPickerViewDataSource, height: CGFloat) -> UIAlertController{
        let editRadiusAlert = UIAlertController(title: TITLE_SELECT_TIME, message: "", preferredStyle: UIAlertController.Style.alert)
        let pickeViewFrame: CGRect = CGRect(x: 5, y: 10, width: 250, height: editRadiusAlert.view.frame.height/3)
        let pickerViewRadius: UIPickerView = UIPickerView(frame: pickeViewFrame)
        pickerViewRadius.delegate = delegate
        pickerViewRadius.dataSource = dataSource
        editRadiusAlert.view.addSubview(pickerViewRadius)
        editRadiusAlert.addAction(UIAlertAction(title: BUTTON_MESSEGE_OK_CANCEL[0], style: UIAlertAction.Style.default,handler:{ (UIAlertAction) in
            if prot != nil{
                prot!.clickButtonPositiv(status: code)
            }
        }))
        editRadiusAlert.addAction(UIAlertAction(title: BUTTON_MESSEGE_OK_CANCEL[1], style: UIAlertAction.Style.cancel, handler: { (UIAlertAction) in
            if prot != nil{
                prot!.clickButtonCanсel(status: code)
            }
        }))
        editRadiusAlert.view.addConstraint(NSLayoutConstraint(item: editRadiusAlert.view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height * 0.5))
        return editRadiusAlert
    }
    
    private func createAlert(status code: Int = 0, title: String = "", messege: String, buttonMessege: [String], protocol prot: AlertProtocol?) -> UIAlertController{
        let alert = UIAlertController(title: title, message: messege, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonMessege[0], style: UIAlertAction.Style.default, handler: { action in
            if prot != nil{
                prot!.clickButtonPositiv(status: code)
            }
        }))
        if (buttonMessege.count > 1){
            alert.addAction(UIAlertAction(title: buttonMessege[1], style: UIAlertAction.Style.default, handler: { action in
                if prot != nil{
                    prot!.clickButtonCanсel(status: code)
                }
            }))
        }
        return alert
    }
    
}
