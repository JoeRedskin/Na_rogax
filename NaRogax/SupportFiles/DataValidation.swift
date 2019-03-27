//
//  DataValidation.swift
//  NaRogax
//
//  Created by Egor on 24/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation

func validateName(name: String) -> Bool {
    if name.count > 1 {
        let range = NSRange(location: 0, length: name.count)
        //let reg = "^[a-zA-Zа-яА-ЯёЁ]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
        let reg = "^[A-Za-zА-Яа-яЁё]{1,30}$"
        let regex = try! NSRegularExpression(pattern: reg)
        if regex.firstMatch(in: name, options: [], range: range) != nil{
            return true
        } else {
            return false
        }
    } else {
        return false
    }
}

func validatePassword(pass: String) -> Bool {
    let reg = "^(?=.*\\d)(?=.*[a-zA-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,32}$"
    let range = NSRange(location: 0, length: pass.count)
    let regex = try! NSRegularExpression(pattern: reg)
    if regex.firstMatch(in: pass, options: [], range: range) != nil{
        return true
    } else {
        return false
    }
}

func validateEmail(email: String) -> Bool {
    let range = NSRange(location: 0, length: email.count)
    let reg = "^[a-zA-Z]{1,2}[A-Za-z0-9._-]{0,62}[@]{1}[A-Za-z0-9]{2,10}[.]{1}[A-Za-z]{2,255}"
    let regex = try! NSRegularExpression(pattern: reg)
    if regex.firstMatch(in: email, options: [], range: range) != nil{
        return true
    } else {
        return false
    }
}

func validatePhone(number: String) -> Bool {
    let range = NSRange(location: 0, length: number.count)
    let reg = "^(\\+7|8)[0-9]{10}"
    let regex = try! NSRegularExpression(pattern: reg)
    if regex.firstMatch(in: number, options: [], range: range) != nil{
        return true
    } else {
        return false
    }
}

func validateCode(code: String) -> Bool {
    if code.count != 5 {
        return false
    }
    
    let reg = "^[0-9]*$"
    let range = NSRange(location: 0, length: code.count)
    let regex = try! NSRegularExpression(pattern: reg)
    if regex.firstMatch(in: code, options: [], range: range) != nil{
        return true
    } else {
        return false
    }
}
