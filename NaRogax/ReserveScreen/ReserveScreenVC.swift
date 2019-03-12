//
//  ReserveScreenVC.swift
//  NaRogax
//
//  Created by User on 11/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class ReserveScreenVC: UIViewController {
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var NameField: UITextField!
    
    @IBOutlet weak var PhoneLabel: UILabel!
    @IBOutlet weak var PhoneField: UITextField!
    @IBOutlet weak var PhoneImage: UIImageView!
    @IBOutlet weak var PhoneErrorLabel: UILabel!
    
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var EmailImage: UIImageView!
    @IBOutlet weak var EmailErrorLabel: UILabel!
    
    @IBOutlet weak var TableInfoLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    
    @IBOutlet weak var ReserveBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ReserveBtn.layer.cornerRadius = 20
        setStyleForTextField(field: NameField, placeholder: "Имя")
        setStyleForTextField(field: PhoneField, placeholder: "Телефон")
        setStyleForTextField(field: EmailField, placeholder: "E-mail")
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NameField.autocapitalizationType = .words
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setStyleForTextField(field: UITextField!, placeholder: String){
        field.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6196078431, green: 0.6196078431, blue: 0.6196078431, alpha: 1)])
        field.layer.masksToBounds = false
        field.layer.shadowRadius = 0.0
        field.layer.shadowOpacity = 1.0
        field.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
        field.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        field.layer.borderWidth = 0.0
    }
    
    
    @IBAction func changeNameFieldText(_ sender: UITextField) {
        if let name = NameField.text {
            if name != "" {
                NameLabel.isHidden = false
            } else {
                NameLabel.isHidden = true
            }
        }
    }
    
    @IBAction func changePhoneFieldText(_ sender: UITextField) {
        if var phone = PhoneField.text {
            if phone != "" {
                PhoneLabel.isHidden = false
                if phone.prefix(1) == "+" {
                    phone = phoneNumberLimit(num: phone, maxlen: 11)
                    PhoneField.text = phone
                    if !validatePhone(number: phone) {
                        PhoneImage.isHidden = false
                        PhoneErrorLabel.isHidden = false
                    } else {
                        PhoneImage.isHidden = true
                        PhoneErrorLabel.isHidden = true
                    }
                } else  {
                    phone = phoneNumberLimit(num: phone, maxlen: 10)
                    PhoneField.text = phone
                    if !validatePhone(number: phone) {
                        PhoneImage.isHidden = false
                        PhoneErrorLabel.isHidden = false
                    } else {
                        PhoneImage.isHidden = true
                        PhoneErrorLabel.isHidden = true
                    }
                }
            } else {
                PhoneImage.isHidden = true
                PhoneErrorLabel.isHidden = true
                PhoneLabel.isHidden = true
            }
        }
    }
    
    @IBAction func changeEmailFieldText(_ sender: UITextField) {
        if let email = EmailField.text {
            if email != "" {
                EmailLabel.isHidden = false
                if !validateEmail(email: email) {
                    EmailErrorLabel.isHidden = false
                    EmailImage.isHidden = false
                } else {
                    EmailErrorLabel.isHidden = true
                    EmailImage.isHidden = true
                }
            } else {
                EmailLabel.isHidden = true
            }
        }
    }
    
    func phoneNumberLimit(num: String, maxlen: Int) -> String {
        if num.count > maxlen {
            
            let start = num.startIndex
            let ind = num.index(start, offsetBy: maxlen)
            let tail = num.index(after: ind)
            let str = num[start..<tail]
            
            return String(str)
        }
        return num
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
    
    func validateEmail(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.count)
        let reg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let regex = try! NSRegularExpression(pattern: reg)
        if regex.firstMatch(in: email, options: [], range: range) != nil{
            return true
        } else {
            return false
        }
    }
}
