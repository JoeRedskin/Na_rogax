//
//  SignInVC.swift
//  NaRogax
//
//  Created by User on 21/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var EmailIcon: UIImageView!
    @IBOutlet weak var SignInBtn: UIButton!
    @IBOutlet weak var ShowPasswordBtn: UIButton!
    
    private var isCorrectEmail = false
    private var isCorrectPassword = false
    
    private var isEmptyEmail = true {
        didSet {
            if !isEmptyEmail && !isEmptyPassword {
                SignInBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                SignInBtn.isEnabled = true
            } else {
                SignInBtn.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                SignInBtn.isEnabled = false
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
            if !isEmptyEmail && !isEmptyPassword {
                SignInBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                SignInBtn.isEnabled = true
            } else {
                SignInBtn.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                SignInBtn.isEnabled = false
            }
            if !isEmptyPassword {
                PasswordLabel.isHidden = false
                ShowPasswordBtn.isHidden = false
            } else {
                PasswordLabel.isHidden = true
                ShowPasswordBtn.isHidden = true
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        SignInBtn.layer.cornerRadius = 20
        setStyleForTextField(field: EmailField, placeholder: "E-mail")
        setStyleForTextField(field: PasswordField, placeholder: "Пароль")
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
    
    @IBAction func showPassword(_ sender: UIButton) {
        PasswordField.isSecureTextEntry = !PasswordField.isSecureTextEntry
    }
    
    @IBAction func emailChanged(_ sender: Any) {
        correctData(field: EmailField, label: ErrorLabel, image: EmailIcon)
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
    
    @IBAction func passwordChanged(_ sender: Any) {
        correctData(field: PasswordField, label: ErrorLabel, image: nil)
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
    
    func showErrorLabel(text: String) {
        ErrorLabel.text = text
        ErrorLabel.isHidden = false
    }
    
    @IBAction func signInBtnTap(_ sender: UIButton) {
        if let email = EmailField.text, let pass = PasswordField.text {
            if validateEmail(email: email) && validatePassword(pass: pass){
                print("SUCCESS")
                /* TO DO: Auth request */
            } else {
                if !validatePassword(pass: pass) {
                    incorrectData(field: PasswordField, label: nil, image: nil)
                    showErrorLabel(text: "Некорректный пароль")
                }
                if !validateEmail(email: email) {
                    incorrectData(field: EmailField, label: nil, image: EmailIcon)
                    showErrorLabel(text: "Некорректный E-mail")
                }
                if !validatePassword(pass: pass) && !validateEmail(email: email) {
                    incorrectData(field: PasswordField, label: nil, image: nil)
                    incorrectData(field: EmailField, label: nil, image: EmailIcon)
                    showErrorLabel(text: "Некорректные E-mail и пароль")
                }
            }
        }
    }
    
}
