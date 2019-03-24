//
//  SignUpVC.swift
//  NaRogax
//
//  Created by User on 22/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var NameErrorLabel: UILabel!
    @IBOutlet weak var PhoneLabel: UILabel!
    @IBOutlet weak var PhoneField: UITextField!
    @IBOutlet weak var PhoneErrorLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var EmailErrorLabel: UILabel!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var RepeatPasswordLabel: UILabel!
    @IBOutlet weak var RepeatPasswordField: UITextField!
    @IBOutlet weak var PasswordErrorLabel: UILabel!
    @IBOutlet weak var SignUpBtn: UIButton!
    @IBOutlet weak var NameImage: UIImageView!
    @IBOutlet weak var PhoneImage: UIImageView!
    @IBOutlet weak var EmailImage: UIImageView!
    @IBOutlet weak var PasswordBtn: UIButton!
    @IBOutlet weak var RepeatPasswordBtn: UIButton!
    @IBOutlet weak var PasswordIcon: UIImageView!
    @IBOutlet weak var RepeatedPasswordIcon: UIImageView!
    
    private var isEmptyName = true {
        didSet {
            if !isEmptyPhone && !isEmptyName && !isEmptyEmail && !isEmptyPassword && !isEmptyRepeatedPassword{
                SignUpBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                SignUpBtn.isEnabled = true
            } else {
                SignUpBtn.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                SignUpBtn.isEnabled = false
            }
            if !isEmptyName {
                NameLabel.isHidden = false
            } else {
                NameLabel.isHidden = true
            }
        }
    }
    
    private var isEmptyPhone = true {
        didSet {
            if !isEmptyPhone && !isEmptyName && !isEmptyEmail && !isEmptyPassword && !isEmptyRepeatedPassword{
                SignUpBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                SignUpBtn.isEnabled = true
            } else {
                SignUpBtn.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                SignUpBtn.isEnabled = false
            }
            if !isEmptyName {
                PhoneLabel.isHidden = false
            } else {
                PhoneLabel.isHidden = true
            }
        }
    }
    
    private var isEmptyEmail = true {
        didSet {
            if !isEmptyPhone && !isEmptyName && !isEmptyEmail && !isEmptyPassword && !isEmptyRepeatedPassword{
                SignUpBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                SignUpBtn.isEnabled = true
            } else {
                SignUpBtn.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                SignUpBtn.isEnabled = false
            }
            if !isEmptyEmail {
                EmailLabel.isHidden = false
            } else {
                EmailLabel.isHidden = true
            }
        }
    }
    
    private var isEmptyPassword = true {
        didSet {
            if !isEmptyPhone && !isEmptyName && !isEmptyEmail && !isEmptyPassword && !isEmptyRepeatedPassword{
                SignUpBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                SignUpBtn.isEnabled = true
            } else {
                SignUpBtn.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                SignUpBtn.isEnabled = false
            }
            if !isEmptyPassword {
                PasswordLabel.isHidden = false
                PasswordBtn.isHidden = false
            } else {
                PasswordLabel.isHidden = true
                PasswordBtn.isHidden = true
            }
        }
    }
    
    private var isEmptyRepeatedPassword = true {
        didSet {
            if !isEmptyPhone && !isEmptyName && !isEmptyEmail && !isEmptyPassword && !isEmptyRepeatedPassword{
                SignUpBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                SignUpBtn.isEnabled = true
            } else {
                SignUpBtn.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                SignUpBtn.isEnabled = false
            }
            if !isEmptyRepeatedPassword {
                RepeatPasswordLabel.isHidden = false
                RepeatPasswordBtn.isHidden = false
            } else {
                RepeatPasswordLabel.isHidden = true
                RepeatPasswordBtn.isHidden = true
            }
        }
    }
    
    func incorrectData(field: UITextField, label: UILabel?, image: UIImageView?) {
        field.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        field.layer.shadowColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        if let lbl = label {
            lbl.isHidden = false
        }
        if let img = image {
            img.isHidden = false
        }
    }
    
    func correctData(field: UITextField, label: UILabel?, image: UIImageView?) {
        field.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        field.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
        
        if let lbl = label {
            lbl.isHidden = true
        }
        if let img = image {
            img.isHidden = true
        }
    }
    
    @IBAction func showPassword(_ sender: UIButton) {
        PasswordField.isSecureTextEntry = !PasswordField.isSecureTextEntry
    }
    
    @IBAction func showRepeatedPassword(_ sender: UIButton) {
        RepeatPasswordField.isSecureTextEntry = !RepeatPasswordField.isSecureTextEntry
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        EmailField.maxLength = 100
        PasswordField.maxLength = 32
        RepeatPasswordField.maxLength = 32
        NameField.maxLength = 30
        PhoneField.maxLength = 11
        SignUpBtn.layer.cornerRadius = 20
        setStyleForTextField(field: EmailField, placeholder: "E-mail")
        setStyleForTextField(field: PasswordField, placeholder: "Пароль")
        setStyleForTextField(field: NameField, placeholder: "Имя")
        setStyleForTextField(field: PhoneField, placeholder: "Телефон")
        setStyleForTextField(field: RepeatPasswordField, placeholder: "Введите пароль еще раз")
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
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
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: field.frame.height))
        field.rightViewMode = .always
    }
    
    @IBAction func passwordChanged(_ sender: Any) {
        correctData(field: PasswordField, label: PasswordErrorLabel, image: PasswordIcon)
        PasswordBtn.isHidden = false
        if let pass = PasswordField.text {
            if pass != "" {
                isEmptyPassword = false
            } else {
                isEmptyPassword = true
            }
        } else {
            isEmptyPassword = true
        }
    }
    
    @IBAction func repeatedPasswordChanged(_ sender: Any) {
        correctData(field: RepeatPasswordField, label: PasswordErrorLabel, image: RepeatedPasswordIcon)
        RepeatPasswordBtn.isHidden = false
        if let pass = RepeatPasswordField.text {
            if pass != "" {
                isEmptyRepeatedPassword = false
            } else {
                isEmptyRepeatedPassword = true
            }
        } else {
            isEmptyRepeatedPassword = true
        }
    }
    
    @IBAction func emailChanged(_ sender: Any) {
        correctData(field: EmailField, label: EmailErrorLabel, image: EmailImage)
        if let email = EmailField.text {
            if email != "" {
                isEmptyEmail = false
            } else {
                isEmptyEmail = true
            }
        } else {
            isEmptyEmail = true
        }
    }
    
    @IBAction func nameChanged(_ sender: Any) {
        correctData(field: NameField, label: NameErrorLabel, image: NameImage)
        if let name = NameField.text {
            if name != "" {
                isEmptyName = false
            } else {
                isEmptyName = true
            }
        } else {
            isEmptyName = true
        }
    }
    
    @IBAction func phoneChanged(_ sender: Any) {
        correctData(field: PhoneField, label: PhoneErrorLabel, image: PhoneImage)
        if let phone = PhoneField.text {
            if phone != "" {
                if phone.prefix(1) == "+" {
                    PhoneField.maxLength = 12
                } else {
                    PhoneField.maxLength = 11
                }
                isEmptyPhone = false
            } else {
                isEmptyPhone = true
            }
        } else {
            isEmptyPhone = true
        }
    }
    
    func showErrorLabel(text: String) {
        PasswordErrorLabel.text = text
        PasswordErrorLabel.isHidden = false
    }
    
    @IBAction func SignUpBtnTap(_ sender: UIButton) {
        if let name = NameField.text, let phone = PhoneField.text, let email = EmailField.text, let pass = PasswordField.text, let rpass = RepeatPasswordField.text {
            if validateName(name: name) && validateEmail(email: email) && validatePassword(pass: pass) && validatePhone(number: phone) && pass == rpass {
                /* TODO: Registration request */
                if (!DataLoader.shared().testNetwork()){
                    self.present(Alert.shared().noInternet(protocol: self as? AlertProtocol), animated: true, completion: nil)
                }else{
                    DataLoader.shared().findUser(email: email){ result in
                        switch result?.code {
                            case 404:
                                let storyboard = UIStoryboard(name: "CheckNumber", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "CheckNumberScreen") as! CheckNumberVC
                                vc.email = email
                                vc.name = name
                                vc.password = pass
                                vc.phone = phone
                                
                                self.navigationController?.pushViewController(vc, animated: true)
                                break
                            case 200:
                                self.incorrectData(field: self.EmailField, label: nil, image: self.EmailImage)
                                self.showErrorLabel(text: "Пользователь с такой почтой уже существует")
                                break
                            case .none:
                                break
                            case .some(_):
                                break
                        }
                    }
                }
            }
            if !validateName(name: name) {
                incorrectData(field: NameField, label: NameErrorLabel, image: NameImage)
            }
            if !validatePhone(number: phone) {
                incorrectData(field: PhoneField, label: PhoneErrorLabel, image: PhoneImage)
            }
            if !validateEmail(email: email) {
                incorrectData(field: EmailField, label: EmailErrorLabel, image: EmailImage)
            }
            if !validatePassword(pass: pass) {
                incorrectData(field: PasswordField, label: nil, image: PasswordIcon)
                incorrectData(field: RepeatPasswordField, label: nil, image: RepeatedPasswordIcon)
                showErrorLabel(text: "Длина пароля должна быть не менее 8 и не более 32 символов. Пароль должен содержать хотя бы одну из букв латинского алфавита (A-z), и одну из арабских цифр (0-9).")
                RepeatPasswordBtn.isHidden = true
                PasswordBtn.isHidden = true
            }else if pass != rpass {
                incorrectData(field: RepeatPasswordField, label: nil, image: RepeatedPasswordIcon)
                showErrorLabel(text: "Пароли должны совпадать")
                RepeatPasswordBtn.isHidden = true
            }
        } else {
            incorrectData(field: NameField, label: NameErrorLabel, image: NameImage)
            incorrectData(field: PhoneField, label: PhoneErrorLabel, image: PhoneImage)
            incorrectData(field: EmailField, label: EmailErrorLabel, image: EmailImage)
            incorrectData(field: PasswordField, label: PasswordErrorLabel, image: PasswordIcon)
            incorrectData(field: RepeatPasswordField, label: nil, image: RepeatedPasswordIcon)
            
            RepeatPasswordBtn.isHidden = true
            PasswordBtn.isHidden = true
            
            showErrorLabel(text: "Все поля должны быть заполнены")
        }
    }
}
