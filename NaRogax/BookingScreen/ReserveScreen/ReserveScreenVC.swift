//
//  ReserveScreenVC.swift
//  NaRogax
//
//  Created by User on 11/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
}

extension String
{
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
}

class ReserveScreenVC: UIViewController {
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var NameImage: UIImageView!
    @IBOutlet weak var NameErrorLabel: UILabel!
    
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
    var date_to = ""
    var time_to = ""
    var date = ""
    
    var table_info = ""
    var table_time = ""
    var table_date = ""
    
    var response: [ReserveResponseData] = []
    
    var isCorrectName = false
    var isCorrectPhone = false
    var isCorrectEmail = false
    
    var isEmptyName = true {
        didSet {
            if !isEmptyName && !isEmptyPhone && !isEmptyEmail {
                ReserveBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                ReserveBtn.isEnabled = true
            } else {
                ReserveBtn.layer.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                ReserveBtn.isEnabled = false
            }
        }
    }
    var isEmptyPhone = true {
        didSet {
            if !isEmptyName && !isEmptyPhone && !isEmptyEmail {
                ReserveBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                ReserveBtn.isEnabled = true
            } else {
                ReserveBtn.layer.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                ReserveBtn.isEnabled = false
            }
        }
    }
    var isEmptyEmail = true {
        didSet {
            if !isEmptyName && !isEmptyPhone && !isEmptyEmail {
                ReserveBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                ReserveBtn.isEnabled = true
            } else {
                ReserveBtn.layer.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                ReserveBtn.isEnabled = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
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
        NameField.maxLength = 30
        
        PhoneField.maxLength = 11
        EmailField.maxLength = 40
        
        let name = UserDefaults.standard.string(forKey: "Name") ?? ""
        let phone = UserDefaults.standard.string(forKey: "Phone") ?? ""
        let email = UserDefaults.standard.string(forKey: "Email") ?? ""
        
        if email + name + phone != "" {
            isCorrectName = true
            isEmptyName = false
            NameField.text = name
            isCorrectEmail = true
            isEmptyEmail = false
            EmailField.text = email
            isCorrectPhone = true
            isEmptyPhone = false
            PhoneField.text = phone
            ReserveBtn.layer.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            ReserveBtn.isEnabled = true
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
                isEmptyName = false
                NameLabel.isHidden = false
                if validateName(name: name) {
                    isCorrectName = true
                } else {
                    isCorrectName = false
                }
            } else {
                isEmptyName = true
                NameLabel.isHidden = true
                isCorrectName = false
            }
        } else {
            isEmptyName = true
            NameLabel.isHidden = true
            isCorrectName = false
        }
    }
    
    @IBAction func changePhoneFieldText(_ sender: UITextField) {
        if let phone = PhoneField.text {
            if phone != "" {
                isEmptyPhone = false
                PhoneLabel.isHidden = false
                if phone.prefix(1) == "+" {
                    PhoneField.maxLength = 12
                } else {
                    PhoneField.maxLength = 11
                }
                if validatePhone(number: phone) {
                    isCorrectPhone = true
                } else {
                    isCorrectPhone = false
                }
            } else {
                isEmptyPhone = true
                PhoneLabel.isHidden = true
                PhoneField.maxLength = 11
                isCorrectPhone = false
            }
        } else {
            isEmptyPhone = true
            PhoneLabel.isHidden = true
            PhoneField.maxLength = 11
            isCorrectPhone = false
        }
    }
    
    @IBAction func changeEmailFieldText(_ sender: UITextField) {
        if let email = EmailField.text {
            if email != "" {
                isEmptyEmail = false
                EmailLabel.isHidden = false
                if validateEmail(email: email) {
                    isCorrectEmail = true
                } else {
                    isCorrectEmail = false
                }
            } else {
                isEmptyEmail = true
                EmailLabel.isHidden = true
                isCorrectEmail = false
            }
        } else {
            isEmptyEmail = true
            EmailLabel.isHidden = true
            isCorrectEmail = false
        }
    }
    
    func validateName(name: String) -> Bool {
        if name.count > 1 {
            let range = NSRange(location: 0, length: name.count)
            let reg = "^[a-zA-Zа-яА-ЯёЁ]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
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
        //let reg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let reg = "^[a-zA-Z]{1,2}[A-Za-z0-9._-]{0,18}[@]{1}[A-Za-z0-9]{2,10}[.]{1}[A-Za-z]{2,10}"
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
                
                if isCorrectPhone {
                    correctData(field: PhoneField, label: PhoneErrorLabel, image: PhoneImage)
                }
                
                if isCorrectEmail {
                    correctData(field: EmailField, label: EmailErrorLabel, image: EmailImage)
                }
                
                if isCorrectName {
                    correctData(field: NameField, label: NameErrorLabel, image: NameImage)
                }
                
                if isCorrectPhone && isCorrectEmail && isCorrectName {
                    correctData(field: PhoneField, label: PhoneErrorLabel, image: PhoneImage)
                    correctData(field: EmailField, label: EmailErrorLabel, image: EmailImage)
                    
                    correctData(field: NameField, label: NameErrorLabel, image: NameImage)
                    
                    UserDefaults.standard.set(name, forKey: "Name")
                    UserDefaults.standard.set(phone, forKey: "Phone")
                    UserDefaults.standard.set(email, forKey: "Email")

                    var data = ReserveTableData()
                    data.date = self.date
                    data.email = email
                    data.name = name
                    data.phone = phone
                    data.table_id = table_id
                    data.time_from = time_from
                    data.date_to = date_to
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
                } else {
                    if !isCorrectPhone {
                        incorrectData(field: PhoneField, label: PhoneErrorLabel, image: PhoneImage)
                    }
                    
                    if !isCorrectEmail {
                        incorrectData(field: EmailField, label: EmailErrorLabel, image: EmailImage)
                    }
                    
                    if !isCorrectName {
                        incorrectData(field: NameField, label: NameErrorLabel, image: NameImage)
                    }
                }
            }
        }
    }
}
