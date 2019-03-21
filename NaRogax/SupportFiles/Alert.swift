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
    func clickButtonPositiv()
    func clickButtonCanсel()
}

class Alert{
    //singl
    private static var uniqueInstance: Alert?
    private init() {}
    
    private let MESSEGE_NO_NETWORK = "Проверьте интернет соединение"
    private let MESSEGE_NO_DOWNLOAD_DISH = "К сожалению мы не смогли загрузить блюда, попробуйте позже"
    private let BUTTON_MESSEGE_OK = ["Ок"]
    
    
    static func shared() -> Alert {
        if uniqueInstance == nil {
            uniqueInstance = Alert()
        }
        return uniqueInstance!
    }
    
    func couldNotDownload(protocol prot: AlertProtocol?) -> UIAlertController{
        return createAlert(messege: MESSEGE_NO_DOWNLOAD_DISH, buttonMessege: BUTTON_MESSEGE_OK, protocol: prot)
    }
    
    func noInternet(protocol prot: AlertProtocol?) -> UIAlertController{
        return createAlert(messege: MESSEGE_NO_NETWORK, buttonMessege: BUTTON_MESSEGE_OK, protocol: prot)
    }
    
    func pickerAlert(protocol prot: AlertProtocol?, delegate: UIPickerViewDelegate,
                     dataSource: UIPickerViewDataSource, height: CGFloat) -> UIAlertController{
        let editRadiusAlert = UIAlertController(title: "Выберите время", message: "", preferredStyle: UIAlertController.Style.alert)
        let pickeViewFrame: CGRect = CGRect(x: 5, y: 10, width: 250, height: editRadiusAlert.view.frame.height/3)
        let pickerViewRadius: UIPickerView = UIPickerView(frame: pickeViewFrame)
        pickerViewRadius.delegate = delegate
        pickerViewRadius.dataSource = dataSource
        editRadiusAlert.view.addSubview(pickerViewRadius)
        editRadiusAlert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default,handler:{ (UIAlertAction) in
            if prot != nil{
                prot!.clickButtonPositiv()
            }
        }))
        editRadiusAlert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: { (UIAlertAction) in
            /*if (self.arrayHour.count > 0){
             self.changeTimeSting.titleLabel?.text = self.hoursWork.getSelectTime()
             }*/
        }))
        editRadiusAlert.view.addConstraint(NSLayoutConstraint(item: editRadiusAlert.view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height * 0.5))
        return editRadiusAlert
    }
    
    private func createAlert(messege: String, buttonMessege: [String], protocol prot: AlertProtocol?) -> UIAlertController{
        let alert = UIAlertController(title: "", message: messege, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonMessege[0], style: UIAlertAction.Style.default, handler: { action in
            if prot != nil{
                prot!.clickButtonPositiv()
            }
        }))
        if (buttonMessege.count > 1){
            alert.addAction(UIAlertAction(title: buttonMessege[1], style: UIAlertAction.Style.default, handler: { action in
                if prot != nil{
                    prot!.clickButtonCanсel()
                }
            }))
        }
        return alert
    }
    
}
