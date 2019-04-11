//
//  SignUpVC.swift
//  NaRogax
//
//  Created by User on 22/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController, UITextFieldDelegate {
    
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
    @IBOutlet weak var RepeatedPasswordErrorLabel: UILabel!
    @IBOutlet weak var Spinner: UIActivityIndicatorView!
    
    private let alertSpinner = AlertSpinner()
    
    /**
     Variable value is true when NameField is empty.
     If one of TextFields empty then sign up button disabled.
     Show hint if NameField is not empty
     */
    
    private var isEmptyName = true {
        didSet {
            if !isEmptyPhone && !isEmptyName && !isEmptyEmail && !isEmptyPassword && !isEmptyRepeatedPassword{
                SignUpBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
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
    
    /**
     Variable value is true when PhoneField is empty.
     If one of TextFields empty then sign up button disabled.
     Show hint if PhoneField is not empty
     */
    
    private var isEmptyPhone = true {
        didSet {
            if !isEmptyPhone && !isEmptyName && !isEmptyEmail && !isEmptyPassword && !isEmptyRepeatedPassword{
                SignUpBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
                SignUpBtn.isEnabled = true
            } else {
                SignUpBtn.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                SignUpBtn.isEnabled = false
            }
            if !isEmptyPhone {
                PhoneLabel.isHidden = false
            } else {
                PhoneLabel.isHidden = true
            }
        }
    }
    
    /**
     Variable value is true when EmailField is empty.
     If one of TextFields empty then sign up button disabled.
     Show hint if EmailField is not empty
     */
    
    private var isEmptyEmail = true {
        didSet {
            if !isEmptyPhone && !isEmptyName && !isEmptyEmail && !isEmptyPassword && !isEmptyRepeatedPassword{
                SignUpBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
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
    
    /**
     Variable value is true when PasswordField is empty.
     If one of TextFields empty then sign up button disabled.
     Show hint if PasswordField is not empty
     */
    
    private var isEmptyPassword = true {
        didSet {
            if !isEmptyPhone && !isEmptyName && !isEmptyEmail && !isEmptyPassword && !isEmptyRepeatedPassword{
                SignUpBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
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
    
    /**
     Variable value is true when EmptyPasswordField is empty.
     If one of TextFields empty then sign up button disabled.
     Show hint if EmptyPasswordField is not empty
     */
    
    private var isEmptyRepeatedPassword = true {
        didSet {
            if !isEmptyPhone && !isEmptyName && !isEmptyEmail && !isEmptyPassword && !isEmptyRepeatedPassword{
                SignUpBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
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
     Show password on PasswordField on tap
     */
    
    @IBAction func showPassword(_ sender: UIButton) {
        PasswordField.isSecureTextEntry = !PasswordField.isSecureTextEntry
    }
    
    /**
     Show password on RepeatedPasswordField on tap
     */
    
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
        PhoneField.maxLength = 18
        SignUpBtn.layer.cornerRadius = 20
        
        EmailField.delegate = self
        NameField.delegate = self
        PhoneField.delegate = self
        PasswordField.delegate = self
        RepeatPasswordField.delegate = self
        
        setStyleForTextField(field: EmailField, placeholder: "E-mail")
        setStyleForTextField(field: PasswordField, placeholder: "Пароль")
        setStyleForTextField(field: NameField, placeholder: "Имя")
        setStyleForTextField(field: PhoneField, placeholder: "Телефон")
        setStyleForTextField(field: RepeatPasswordField, placeholder: "Введите пароль еще раз")
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        insetDefault = ScrollView.contentInset
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
            
            // move if keyboard hide input field
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
        //view.endEditing(true)
        guard activeField != nil else {
            return
        }
        
        activeField?.resignFirstResponder()
        activeField = nil
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
     PasswordField text changing handler
     */
    
    @IBAction func passwordChanged(_ sender: Any) {
        correctData(field: PasswordField, label: PasswordErrorLabel, image: PasswordIcon)
        PasswordErrorLabel.text = "Некорректный пароль"
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
     Remove text on PasswordField text edit begin
     */
    
    @IBAction func passwordDidBegin(_ sender: UITextField) {
        sender.text = ""
    }
    
    /**
     RepeatedPasswordField text changing handler
     */
    
    @IBAction func repeatedPasswordChanged(_ sender: Any) {
        correctData(field: RepeatPasswordField, label: RepeatedPasswordErrorLabel, image: RepeatedPasswordIcon)
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
    
    /**
     EmailField text changing handler
     */
    
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
    
    /**
     NameField text changing handler
     */
    
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
    
    /**
     Phone begin editing handler
     */
    
    @IBAction func phoneBeginEditing(_ sender: Any) {
        if let phone = PhoneField.text {
            if phone == "" {
                PhoneField.text = "+7"
                PhoneLabel.isHidden = false
            }
        }
    }
    
    /**
     Phone end editing handler
     */
    
    @IBAction func phoneEndEditing(_ sender: Any) {
        if let phone = PhoneField.text {
            if phone == "+7" {
                PhoneField.text = ""
                isEmptyPhone = true
                //PhoneLabel.isHidden = true
            }
        }
    }
    /**
     PhoneField text changing handler
     */
    
    @IBAction func phoneChanged(_ sender: Any) {
        correctData(field: PhoneField, label: PhoneErrorLabel, image: PhoneImage)
        if let phone = PhoneField.text {
            if phone.count <= 1 {
                PhoneField.text = "+7"
                isEmptyPhone = true
                PhoneLabel.isHidden = false
            } else if phone == "+7" {
                isEmptyPhone = true
                PhoneLabel.isHidden = false
            } else {
                isEmptyPhone = false
                PhoneField.text = phone.applyPatternOnNumbers(pattern: "+# (###) ###-##-##", replacmentCharacter: "#")
            }
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
    
    /**
     Show error label
     - Parameters:
        - text: Error text which will be showed
     */
    
    func showErrorLabel(text: String) {
        RepeatedPasswordErrorLabel.text = text
        RepeatedPasswordErrorLabel.isHidden = false
    }
    
    /**
     Sign up button tap
     */
    
    @IBAction func SignUpBtnTap(_ sender: UIButton) {
        EmailErrorLabel.text = "Пожалуйста, введите корректный адрес"
        dismissKeyboard()
        if let name = NameField.text, let phone = PhoneField.text, let email = EmailField.text, let pass = PasswordField.text, let rpass = RepeatPasswordField.text {
            if validateName(name: name) && validateEmail(email: email) && validatePassword(pass: pass) && validatePhone(number: phone) && pass == rpass {
                self.SignUpBtn.isEnabled = false
                if (!DataLoader.shared().testNetwork()){
                    self.present(Alert.shared().noInternet(protocol: self as? AlertProtocol), animated: true, completion: nil)
                    self.SignUpBtn.isEnabled = true
                }else{
                    self.Spinner.startAnimating()
                    self.alertSpinner.showSpinner(onView: self.view)
                    DataLoader.shared().findUser(email: email){ result in
                        switch result?.code {
                            case 404:
                                let storyboard = UIStoryboard(name: "CheckNumber", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "CheckNumberScreen") as! CheckNumberVC
                                vc.email = email
                                vc.name = name
                                vc.password = pass
                                vc.phone = phone
                                let data = RequestUserEmail(email: email)
                                DataLoader.shared().verifyEmail(data: data){ result in
                                    if result?.code == 200 {
                                        self.alertSpinner.removeSpinner()
                                        self.Spinner.stopAnimating()
                                        self.SignUpBtn.isEnabled = true
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }else{
                                        self.alertSpinner.removeSpinner()
                                    }
                                }
                                break
                            case 200:
                                self.EmailErrorLabel.text = "Пользователь с такой почтой уже существует"
                                self.incorrectData(field: self.EmailField, label: self.EmailErrorLabel, image: self.EmailImage)
                                
                                self.alertSpinner.removeSpinner()
                                break
                            case .none:
                                break
                            case .some(_):
                                break
                        }
                        self.Spinner.stopAnimating()
                        self.SignUpBtn.isEnabled = true
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
                incorrectData(field: PasswordField, label: PasswordErrorLabel, image: PasswordIcon)
                PasswordErrorLabel.text = "Длина пароля должна быть не менее 8 и не более 32 символов. Пароль должен содержать хотя бы одну из букв латинского алфавита (A-z), и одну из арабских цифр (0-9)."
                PasswordBtn.isHidden = true
            }
            if pass != rpass {
                incorrectData(field: RepeatPasswordField, label: nil, image: RepeatedPasswordIcon)
                showErrorLabel(text: "Пароли не совпадают")
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
