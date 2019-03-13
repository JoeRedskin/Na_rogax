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
    
    var table_id = 0
    var time_from = ""
    var time_to = ""
    var date = ""
    
    var table_info = ""
    var table_time = ""
    var table_date = ""
    
    var response: [ReserveResponseData] = []
    
    var isCorrectName = false
    var isCorrectPhone = false
    var isCorrectEmail = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        backButton.title = "Бронирование"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        ReserveBtn.layer.cornerRadius = 20
        setStyleForTextField(field: NameField, placeholder: "Имя")
        setStyleForTextField(field: PhoneField, placeholder: "Телефон")
        setStyleForTextField(field: EmailField, placeholder: "E-mail")
        
        TableInfoLabel.text = table_info
        DateLabel.text = table_date
        TimeLabel.text = table_time
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NameField.autocapitalizationType = .words
        
        let name = UserDefaults.standard.string(forKey: "Name") ?? ""
        let phone = UserDefaults.standard.string(forKey: "Phone") ?? ""
        let email = UserDefaults.standard.string(forKey: "Email") ?? ""
        
        if email + name + phone != "" {
            isCorrectName = true
            NameField.text = name
            isCorrectEmail = true
            EmailField.text = email
            isCorrectPhone = true
            PhoneField.text = phone
            ReserveBtn.layer.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            NameLabel.isHidden = false
            PhoneLabel.isHidden = false
            EmailLabel.isHidden = false
        }
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
    
    func incorrectData(field: UITextField, label: UILabel, image: UIImageView) {
        field.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        field.layer.shadowColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        label.isHidden = false
        image.isHidden = false
        
        ReserveBtn.layer.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
    }
    
    func correctData(field: UITextField, label: UILabel, image: UIImageView) {
        field.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        field.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
        
        label.isHidden = true
        image.isHidden = true
    }
    
    @IBAction func changeNameFieldText(_ sender: UITextField) {
        if let name = NameField.text {
            if name != "" {
                NameLabel.isHidden = false
                isCorrectName = true
            } else {
                NameLabel.isHidden = true
                isCorrectName = false
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
                        incorrectData(field: PhoneField, label: PhoneErrorLabel, image: PhoneImage)
                        isCorrectPhone = false
                    } else {
                        correctData(field: PhoneField, label: PhoneErrorLabel, image: PhoneImage)
                        isCorrectPhone = true
                        if let email = EmailField.text, let name = NameField.text {
                            if validateEmail(email: email) && name != ""{
                                ReserveBtn.layer.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                            }
                        }
                    }
                } else  {
                    phone = phoneNumberLimit(num: phone, maxlen: 10)
                    PhoneField.text = phone
                    if !validatePhone(number: phone) {
                        incorrectData(field: PhoneField, label: PhoneErrorLabel, image: PhoneImage)
                        isCorrectPhone = false
                    } else {
                        correctData(field: PhoneField, label: PhoneErrorLabel, image: PhoneImage)
                        isCorrectPhone = true
                        if let email = EmailField.text, let name = NameField.text{
                            if validateEmail(email: email) && name != ""{
                                ReserveBtn.layer.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                            }
                        }
                    }
                }
            } else {
                correctData(field: PhoneField, label: PhoneErrorLabel, image: PhoneImage)
                ReserveBtn.layer.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                isCorrectPhone = false
            }
        }
    }
    
    @IBAction func changeEmailFieldText(_ sender: UITextField) {
        if let email = EmailField.text {
            if email != "" {
                EmailLabel.isHidden = false
                if !validateEmail(email: email) {
                    incorrectData(field: EmailField, label: EmailErrorLabel, image: EmailImage)
                    isCorrectEmail = false
                } else {
                    correctData(field: EmailField, label: EmailErrorLabel, image: EmailImage)
                    isCorrectEmail = true
                    if let phone = PhoneField.text, let name = NameField.text {
                        if validatePhone(number: phone) && name != ""{
                            ReserveBtn.layer.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                        }
                    }
                }
            } else {
                correctData(field: EmailField, label: EmailErrorLabel, image: EmailImage)
                ReserveBtn.layer.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                isCorrectEmail = false
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
    @IBAction func onReserveBtnTap(_ sender: UIButton) {
        if (!Reachability.isConnectedToNetwork()){
            let alert = UIAlertController(title: "", message: "Проверьте интернет соединение", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            if let name = NameField.text, let phone = PhoneField.text, let email = EmailField.text {
                if isCorrectPhone && isCorrectEmail && isCorrectName {
                    UserDefaults.standard.set(name, forKey: "Name")
                    print(UserDefaults.standard.string(forKey: "Name") ?? "")
                    UserDefaults.standard.set(phone, forKey: "Phone")
                    print(UserDefaults.standard.string(forKey: "Phone") ?? "")
                    UserDefaults.standard.set(email, forKey: "Email")
                    print(UserDefaults.standard.string(forKey: "Email") ?? "")
                    var data = ReserveTableData()
                    data.date = self.date
                    data.email = email
                    data.name = name
                    data.phone = phone
                    data.table_id = table_id
                    data.time_from = time_from
                    data.time_to = time_to
                    
                    let dataLoader = DataLoader()
                    dataLoader.reserveTable(data: data){ items in self.response.append(contentsOf: items)
                        print(self.response[0])
                        if self.response[0].code == 451 {
                            
                            let storyboard = UIStoryboard(name: "ReservationCanceled", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "ReservationCanceled") as! ReservationCanceledVC
                            vc.name = data.name
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                        } else if self.response[0].code == 200 {
                            
                            let storyboard = UIStoryboard(name: "ReservationConfirmed", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "ReservationConfirmed") as! ReservationConfirmedVC
                            vc.name = data.name
                            vc.phone = data.phone
                            self.navigationController?.pushViewController(vc, animated: true)

                        }
                    }
                }
            }
        }
    }
}
