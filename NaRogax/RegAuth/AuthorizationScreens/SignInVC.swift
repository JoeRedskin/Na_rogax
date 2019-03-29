//
//  SignInVC.swift
//  NaRogax
//
//  Created by User on 21/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class SignInVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var EmailIcon: UIImageView!
    @IBOutlet weak var PasswordIcon: UIImageView!
    @IBOutlet weak var SignInBtn: UIButton!
    @IBOutlet weak var ShowPasswordBtn: UIButton!
    
    private var isCorrectEmail = false
    private var isCorrectPassword = false
    
    private var isEmptyEmail = true {
        didSet {
            if !isEmptyEmail && !isEmptyPassword {
                SignInBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
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
                SignInBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
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
    
    var activeField: UITextField?
    var keyboardHeight: CGFloat!
    private var isScrolled = false
    
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
        SignInBtn.layer.cornerRadius = 20
        setStyleForTextField(field: EmailField, placeholder: "E-mail")
        setStyleForTextField(field: PasswordField, placeholder: "Пароль")
        
        EmailField.delegate = self
        PasswordField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeField = textField
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeField?.resignFirstResponder()
        activeField = nil
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardHeight != nil {
            return
        }
        
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        keyboardHeight = keyboardFrame.height
        
        // move if keyboard hide input field
        let y = (activeField?.frame.origin.y) ?? 0
        let h = (activeField?.frame.size.height) ?? 0
        let distanceToBottom = self.view.frame.size.height - y - h
        let collapseSpace = keyboardHeight - distanceToBottom
        isScrolled = true
        if collapseSpace < 0 {
            print(3)
            isScrolled = false
            // no collapse
            return
        }
        self.view.frame.origin.y -= keyboardHeight
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if isScrolled {
            self.view.frame.origin.y += keyboardHeight
        }
        isScrolled = false
        keyboardHeight = nil
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func dismissKeyboard() {
        guard activeField != nil else {
            return
        }
        
        activeField?.resignFirstResponder()
        activeField = nil
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
        if !field.isEditing {
            field.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
            field.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        }
        
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
        correctData(field: PasswordField, label: ErrorLabel, image: PasswordIcon)
        ShowPasswordBtn.isHidden = false
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
    
    @IBAction func fieldStartEditing(_ sender: UITextField) {
        sender.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        sender.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @IBAction func fieldEndEditing(_ sender: UITextField) {
        sender.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        sender.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
    }
    
    func showErrorLabel(text: String) {
        ErrorLabel.text = text
        ErrorLabel.isHidden = false
    }
    
    @IBAction func signInBtnTap(_ sender: UIButton) {
        EmailField.resignFirstResponder()
        PasswordField.resignFirstResponder()
        if let email = EmailField.text, let pass = PasswordField.text {
            if validateEmail(email: email) && validatePassword(pass: pass){                
                /* TO DO: Auth request */
                self.SignInBtn.isEnabled = false
                if (!DataLoader.shared().testNetwork()){
                    self.present(Alert.shared().noInternet(protocol: self as? AlertProtocol), animated: true, completion: nil)
                    self.SignInBtn.isEnabled = true
                }else{
                    var data = RequestPostAuth()
                    data.email = email
                    data.password = pass
                    DataLoader.shared().authorizeUser(data: data){ result, error  in
                        if result.code == 200 {
                            UserDefaultsData.shared().saveEmail(email: email)
                            self.navigationController?.popViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                        } else {
                            self.incorrectData(field: self.EmailField, label: nil, image: self.EmailIcon)
                            self.incorrectData(field: self.PasswordField, label: nil, image: self.PasswordIcon)
                            self.showErrorLabel(text: "Неверный пароль или E-mail")
                        }
                        self.SignInBtn.isEnabled = true
                    }
                }
            } else {
                if !validatePassword(pass: pass) {
                    incorrectData(field: PasswordField, label: nil, image: PasswordIcon)
                    ShowPasswordBtn.isHidden = true
                    showErrorLabel(text: "Некорректный пароль")
                }
                if !validateEmail(email: email) {
                    incorrectData(field: EmailField, label: nil, image: EmailIcon)
                    showErrorLabel(text: "Некорректный E-mail")
                }
                if !validatePassword(pass: pass) && !validateEmail(email: email) {
                    incorrectData(field: PasswordField, label: nil, image: PasswordIcon)
                    incorrectData(field: EmailField, label: nil, image: EmailIcon)
                    showErrorLabel(text: "Некорректные E-mail и пароль")
                }
            }
        }
    }
    
    
    @IBAction func goToSignUp(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SignUpScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignUpScreen") as! SignUpVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func ForgotPasswordTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "PasswordRecoveryMain", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainRecoveryScreen") as! PasswordRecoveryMainVC
        navigationController?.pushViewController(vc, animated: true)
    }    
}
