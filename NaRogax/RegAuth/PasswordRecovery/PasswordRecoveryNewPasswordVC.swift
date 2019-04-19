//
//  PasswordRecoveryNewPasswordVC.swift
//  NaRogax
//
//  Created by Egor on 23/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class PasswordRecoveryNewPasswordVC: UIViewController, UITextFieldDelegate, AlertProtocol{
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
    @IBOutlet weak var PasswordErrorLabel: UILabel!
    @IBOutlet weak var RepeatedPasswordLabel: UILabel!
    @IBOutlet weak var RepeatedPasswordField: UITextField!
    @IBOutlet weak var RepeatedPasswordIcon: UIImageView!
    @IBOutlet weak var RepeatedPasswordBtn: UIButton!
    @IBOutlet weak var RepeatedPasswordErrorLabel: UILabel!
    @IBOutlet weak var CodeLabel: UILabel!
    @IBOutlet weak var CodeField: UITextField!
    @IBOutlet weak var CodeIcon: UIImageView!
    @IBOutlet weak var CodeErrorLabel: UILabel!
    @IBOutlet weak var ChangePasswordBtn: UIButton!
    @IBOutlet weak var ScrollView: UIScrollView!
    
    private let alertSpinner = AlertSpinner()
    
    /**
     User email
     - Important: Get from PasswordRecoveryMain screen
     */
    var email = ""
    
    /**
     Variable value is true when PasswordField is empty.
     If one of TextFields empty then change password button disabled.
     Show hint if PasswordField is not empty
     */
    
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
    
    /**
     Variable value is true when RepeatedPasswordField is empty.
     If one of TextFields empty then change password button disabled.
     Show hint if RepeatedPasswordField is not empty
     */
    
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
    
    /**
     Variable value is true when CodeField is empty.
     If one of TextFields empty then change password button disabled.
     Show hint if CodeField is not empty
     */
    
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
    
    /**
     Textfield which is editing now.
     - Important: Can be nil
     */
    
    var activeField: UITextField?
    
    /**
     Height of keyboard
     */
    
    var keyboardHeight: CGFloat!
    
    /**
     Inset of scroll view.
     */
    
    private var insetDefault: UIEdgeInsets = UIEdgeInsets()
    
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
        
        PasswordField.delegate = self
        RepeatedPasswordField.delegate = self
        CodeField.delegate = self
        
        ScrollView.isScrollEnabled = false
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        insetDefault = ScrollView.contentInset
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    /**
     Keyboard showing handler
     */
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardHeight != nil {
            return
        }
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            
            if let y = activeField?.frame.origin.y{
                if let  h = activeField?.frame.size.height{
                    let distanceToBottom = self.ScrollView.frame.size.height - y - h
                    let collapseSpace = keyboardHeight - distanceToBottom
                    if collapseSpace < 0 {
                        // no collapse
                        return
                    }
                    
                    var contentInset:UIEdgeInsets = self.ScrollView.contentInset
                    contentInset.bottom = keyboardSize.size.height + 40
                    ScrollView.contentInset = contentInset
                }
            }            
        }
    }
    
    /**
     Keyboard hide handler
     */
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.ScrollView.contentInset = self.insetDefault
        keyboardHeight = nil
    }
    
    /**
     Remove keyboard on view tap
     */
    
    @objc func dismissKeyboard() {
        guard activeField != nil else {
            return
        }
        
        activeField?.resignFirstResponder()
        activeField = nil
    }
    
    /**
     Highlight not valid data
     - Author: Egor
     - parameters:
        - field: TextField which should be highlighted
        - label: Error hint which should be shown
        - image: Icon of TextField which will be highlighted
     */
    
    func incorrectData(field: UITextField, label: UILabel?, image: UIImageView?) {
        field.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        field.layer.shadowColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        if let lbl = label {
            if label == CodeErrorLabel{
                if CodeField.text?.count ?? 0 < 5 {
                    lbl.text = "Код состоит из 5 символов"
                }else{
                    lbl.text = "Введенный код не верен"
                }
            }
            lbl.isHidden = false
        }
        if let img = image {
            img.isHidden = false
        }
    }
    
    /**
     Remove highlight from Field
     - Author: Egor
     - parameters:
        - field: The field from which you want to remove the highlight
        - label: Error hint which should be hiden. Can be nil
        - image: Icon of TextField which will be hiden. Can be nil
     */
    
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
    
    /**
     Set style for text field
     - Author: Egor
     - parameters:
        - field: TextField which should be styled
        - placeholder: Placeholder text for TextField
     */
    
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
    
    /**
     Change color of TextField placeholder
     - Parameters:
        - field: TextField in which will change placeholder color
        - color: New color of placeholder
     */
    
    func changePlaceholderColor(field: UITextField, color: UIColor){
        field.attributedPlaceholder = NSAttributedString(string: field.placeholder!,
                                                         attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    /**
     Show error label
     - Parameters:
        - text: Error text which will be showed
     */
    
    func showErrorLabel(text: String) {
        PasswordErrorLabel.text = text
        PasswordErrorLabel.isHidden = false
    }
    
    /**
     Show password on PasswordField on tap
     */
    
    @IBAction func showPassword(_ sender: UIButton) {
        PasswordField.isSecureTextEntry = !PasswordField.isSecureTextEntry
    }
    
    /**
     Show password on RepeatedPasswordField on tap
     */
    
    @IBAction func showRepeatedPassword(_ sender: UIButton) {
        RepeatedPasswordField.isSecureTextEntry = !RepeatedPasswordField.isSecureTextEntry
    }
    
    /**
     PasswordField text changing handler
     */
    
    @IBAction func passwordChanged(_ sender: Any) {
        ScrollView.isScrollEnabled = false
        correctData(field: PasswordField, label: PasswordErrorLabel, image: PasswordIcon)
        PasswordErrorLabel.text = "Пароль"
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
    
    /**
     RepeatedPasswordField text changing handler
     */
    
    @IBAction func repeatedPasswordChanged(_ sender: Any) {
        correctData(field: RepeatedPasswordField, label: RepeatedPasswordErrorLabel, image: RepeatedPasswordIcon)
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
    
    /**
     CodeField text changing handler
     */
    
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
    
    /**
     Field start editing handler
     */
    
    @IBAction func fieldStartEditing(_ sender: UITextField) {
        sender.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        sender.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        changePlaceholderColor(field: sender, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    }
    
    /**
     Field end editing handler
     */
    
    @IBAction func fieldEndEditing(_ sender: UITextField) {
        sender.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        sender.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
        
        changePlaceholderColor(field: sender, color: #colorLiteral(red: 0.6196078431, green: 0.6196078431, blue: 0.6196078431, alpha: 1))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        alertSpinner.removeSpinner()
    }
    
    /**
     Change password button tap
     */
    
    @IBAction func ChangePasswordTap(_ sender: UIButton) {
        PasswordField.resignFirstResponder()
        RepeatedPasswordField.resignFirstResponder()
        CodeField.resignFirstResponder()
        if let pass = PasswordField.text, let rpass = RepeatedPasswordField.text, let code = CodeField.text, let icode = Int(code) {
            if validateCode(code: code) && validatePassword(pass: pass) && pass == rpass {
                self.ChangePasswordBtn.isEnabled = false
                var data = RequestPostPasswordRecovery()
                data.code = icode
                data.email = self.email
                data.password = pass
                alertSpinner.showSpinner(onView: self.view)
                if (!DataLoader.shared().testNetwork()){
                    self.present(Alert.shared().noInternet(protocol: nil), animated: true, completion: nil)
                    self.ChangePasswordBtn.isEnabled = true
                    self.alertSpinner.removeSpinner()
                }else{
                    DataLoader.shared().passwordRecovery(data: data){ result in
                        if result?.code == 200 {
                            self.present(Alert.shared().changePassword(protocol: self as AlertProtocol), animated: true, completion: nil)
                        } else if result?.code == 422 {
                            self.incorrectData(field: self.CodeField, label: self.CodeErrorLabel, image: self.CodeIcon)
                        }
                        self.ChangePasswordBtn.isEnabled = true
                    }
                    self.alertSpinner.removeSpinner()
                }
            }
            if !validateCode(code: code) {
                incorrectData(field: CodeField, label: CodeErrorLabel, image: CodeIcon)
            }
            if !validatePassword(pass: pass) {
                incorrectData(field: PasswordField, label: PasswordErrorLabel, image: PasswordIcon)
                PasswordErrorLabel.text = "Длина пароля должна быть не менее 8 и не более 32 символов. Пароль должен содержать хотя бы одну из букв латинского алфавита (A-z), и одну из арабских цифр (0-9)."
                ScrollView.isScrollEnabled = true
                PasswordBtn.isHidden = true
            }
            if pass != rpass {
                incorrectData(field: RepeatedPasswordField, label: RepeatedPasswordErrorLabel, image: RepeatedPasswordIcon)
                RepeatedPasswordBtn.isHidden = true
            }
        }
    }

}
