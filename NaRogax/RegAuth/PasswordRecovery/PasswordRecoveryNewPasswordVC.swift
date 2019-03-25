//
//  PasswordRecoveryNewPasswordVC.swift
//  NaRogax
//
//  Created by Egor on 23/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class PasswordRecoveryNewPasswordVC: UIViewController, AlertProtocol{
    func clickButtonPositiv(status: Int) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    func clickButtonCanсel(status: Int) {
        print("do nothing")
    }
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var PasswordIcon: UIImageView!
    @IBOutlet weak var PasswordBtn: UIButton!
    
    @IBOutlet weak var RepeatedPasswordLabel: UILabel!
    @IBOutlet weak var RepeatedPasswordField: UITextField!
    @IBOutlet weak var RepeatedPasswordIcon: UIImageView!
    @IBOutlet weak var RepeatedPasswordBtn: UIButton!
    @IBOutlet weak var PasswordErrorLabel: UILabel!
    
    @IBOutlet weak var CodeLabel: UILabel!
    @IBOutlet weak var CodeField: UITextField!
    @IBOutlet weak var CodeIcon: UIImageView!
    @IBOutlet weak var CodeErrorLabel: UILabel!
    
    @IBOutlet weak var ChangePasswordBtn: UIButton!
    
    var email = ""
    
    private var isEmptyPassword = true {
        didSet {
            if !isEmptyPassword && !isEmptyRepeatedPassword && !isEmptyCode {
                ChangePasswordBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
                ChangePasswordBtn.isEnabled = true
            } else {
                ChangePasswordBtn.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                ChangePasswordBtn.isEnabled = false
            }
            if !isEmptyPassword {
                PasswordLabel.isHidden = false
            } else {
                PasswordLabel.isHidden = true
            }
        }
    }
    
    private var isEmptyRepeatedPassword = true {
        didSet {
            if !isEmptyPassword && !isEmptyRepeatedPassword && !isEmptyCode {
                ChangePasswordBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
                ChangePasswordBtn.isEnabled = true
            } else {
                ChangePasswordBtn.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                ChangePasswordBtn.isEnabled = false
            }
            if !isEmptyRepeatedPassword {
                RepeatedPasswordLabel.isHidden = false
            } else {
                RepeatedPasswordLabel.isHidden = true
            }
        }
    }
    
    private var isEmptyCode = true {
        didSet {
            if !isEmptyPassword && !isEmptyRepeatedPassword && !isEmptyCode {
                ChangePasswordBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
                ChangePasswordBtn.isEnabled = true
            } else {
                ChangePasswordBtn.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                ChangePasswordBtn.isEnabled = false
            }
            if !isEmptyCode {
                CodeLabel.isHidden = false
            } else {
                CodeLabel.isHidden = true
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
        
        ChangePasswordBtn.layer.cornerRadius = 20
        PasswordField.maxLength = 32
        RepeatedPasswordField.maxLength = 32
        CodeField.maxLength = 5
        setStyleForTextField(field: PasswordField, placeholder: "Новый пароль")
        setStyleForTextField(field: RepeatedPasswordField, placeholder: "Введите пароль еще раз")
        setStyleForTextField(field: CodeField, placeholder: "Код из E-mail")
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
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
    
    func validateCode(code: String) -> Bool {
        let reg = "^[0-9]{5}"
        let range = NSRange(location: 0, length: code.count)
        let regex = try! NSRegularExpression(pattern: reg)
        if regex.firstMatch(in: code, options: [], range: range) != nil{
            return true
        } else {
            return false
        }
    }
    
    func showErrorLabel(text: String) {
        PasswordErrorLabel.text = text
        PasswordErrorLabel.isHidden = false
    }
    
    @IBAction func showPassword(_ sender: UIButton) {
        PasswordField.isSecureTextEntry = !PasswordField.isSecureTextEntry
    }
    
    @IBAction func showRepeatedPassword(_ sender: UIButton) {
        RepeatedPasswordField.isSecureTextEntry = !RepeatedPasswordField.isSecureTextEntry
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
        correctData(field: RepeatedPasswordField, label: PasswordErrorLabel, image: RepeatedPasswordIcon)
        RepeatedPasswordBtn.isHidden = false
        if let pass = RepeatedPasswordField.text {
            if pass != "" {
                isEmptyRepeatedPassword = false
            } else {
                isEmptyRepeatedPassword = true
            }
        } else {
            isEmptyRepeatedPassword = true
        }
    }
    
    @IBAction func codeChanged(_ sender: Any) {
        correctData(field: CodeField, label: CodeErrorLabel, image: CodeIcon)
        if let code = CodeField.text {
            if code != "" {
                isEmptyCode = false
            } else {
                isEmptyCode = true
            }
        } else {
            isEmptyCode = true
        }
    }
    
    
    @IBAction func ChangePasswordTap(_ sender: UIButton) {
        if let pass = PasswordField.text, let rpass = RepeatedPasswordField.text, let code = CodeField.text, let icode = Int(code) {
            if validateCode(code: code) && validatePassword(pass: pass) && pass == rpass {
                /* TODO: Send request for change password */
                self.ChangePasswordBtn.isEnabled = false
                var data = RequestPostPasswordRecovery()
                data.code = icode
                data.email = self.email
                data.password = pass
                if (!DataLoader.shared().testNetwork()){
                    self.present(Alert.shared().noInternet(protocol: nil), animated: true, completion: nil)
                    self.ChangePasswordBtn.isEnabled = true
                }else{
                    DataLoader.shared().passwordRecovery(data: data){ result in
                        if result?.code == 200 {
                            self.present(Alert.shared().changePassword(protocol: self as AlertProtocol), animated: true, completion: nil)
                        }
                        self.ChangePasswordBtn.isEnabled = true
                    }
                }
            }
            if !validateCode(code: code) {
                incorrectData(field: CodeField, label: CodeErrorLabel, image: CodeIcon)
            }
            if !validatePassword(pass: pass) {
                incorrectData(field: PasswordField, label: nil, image: PasswordIcon)
                incorrectData(field: RepeatedPasswordField, label: nil, image: RepeatedPasswordIcon)
                showErrorLabel(text: "Длина пароля должна быть не менее 8 и не более 32 символов. Пароль должен содержать хотя бы одну из букв латинского алфавита (A-z), и одну из арабских цифр (0-9).")
                RepeatedPasswordBtn.isHidden = true
                PasswordBtn.isHidden = true
            } else if pass != rpass {
                incorrectData(field: RepeatedPasswordField, label: nil, image: RepeatedPasswordIcon)
                showErrorLabel(text: "Пароли должны совпадать")
                RepeatedPasswordBtn.isHidden = true
            }
        }
    }

}
