//
//  EditProfileVC.swift
//  NaRogax
//
//  Created by User on 25/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var NameIcon: UIImageView!
    @IBOutlet weak var NameErrorLabel: UILabel!
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var DateField: UITextField!
    @IBOutlet weak var DateIcon: UIImageView!
    @IBOutlet weak var DateErrorLabel: UILabel!
    
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var EmailIcon: UIImageView!
    @IBOutlet weak var EmailErrorLabel: UILabel!
    
    @IBOutlet weak var PhoneLabel: UILabel!
    @IBOutlet weak var PhoneField: UITextField!
    @IBOutlet weak var PhoneIcon: UIImageView!
    @IBOutlet weak var PhoneErrorLabel: UILabel!
    
    @IBOutlet weak var SaveChangesBtn: UIButton!
    
    /**
     User name
     - Important: Get from MainProfile screen
     */
    var Name = ""
    /**
     User email
     - Important: Get from MainProfile screen
     */
    var Email = ""
    /**
     User phone
     - Important: Get from MainProfile screen
     */
    var Phone = ""
    /**
     User birth date
     - Important: Get from MainProfile screen
     */
    var BirthDate = ""
    
    /**
     Variable value is true when NameField is empty.
     If one of TextFields empty then save changes button disabled.
     Show hint if NameField is not empty
     */
    
    private var isEmptyName = false {
        didSet {
            if !isEmptyPhone && !isEmptyName && !isEmptyEmail{
                SaveChangesBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
                SaveChangesBtn.isEnabled = true
            } else {
                SaveChangesBtn.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                SaveChangesBtn.isEnabled = false
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
     If one of TextFields empty then save changes button disabled.
     Show hint if PhoneField is not empty
     */
    
    private var isEmptyPhone = false {
        didSet {
            if !isEmptyPhone && !isEmptyName && !isEmptyEmail{
                SaveChangesBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
                SaveChangesBtn.isEnabled = true
            } else {
                SaveChangesBtn.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                SaveChangesBtn.isEnabled = false
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
     If one of TextFields empty then save changes button disabled.
     Show hint if EmailField is not empty
     */
    
    private var isEmptyEmail = false {
        didSet {
            if !isEmptyPhone && !isEmptyName && !isEmptyEmail{
                SaveChangesBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
                SaveChangesBtn.isEnabled = true
            } else {
                SaveChangesBtn.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                SaveChangesBtn.isEnabled = false
            }
            if !isEmptyEmail {
                EmailLabel.isHidden = false
            } else {
                EmailLabel.isHidden = true
            }
        }
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
        
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.setNeedsStatusBarAppearanceUpdate()
        SaveChangesBtn.layer.cornerRadius = 20
        
        NameField.text = Name
        PhoneField.text = Phone
        EmailField.text = Email
        DateField.text = BirthDate
        
        setStyleForTextField(field: NameField, placeholder: "Имя")
        NameField.maxLength = 30
        setStyleForTextField(field: EmailField, placeholder: "E-mail")
        EmailField.maxLength = 100
        setStyleForTextField(field: PhoneField, placeholder: "Телефон")
        PhoneField.maxLength = 12
        setStyleForTextField(field: DateField, placeholder: "Дата рождения")
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let datePicker = UIDatePicker()
        datePicker.locale = Locale.init(identifier: "ru")
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.maximumDate = Date()
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
        
        datePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        DateField.inputView = datePicker
    }
    
    /**
     Run when datepicker value changed.
     */
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        DateField.text = dateFormatter.string(from: picker.date)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
     EmailField text changing handler
     */
    
    @IBAction func emailChanged(_ sender: Any) {
        correctData(field: EmailField, label: EmailErrorLabel, image: EmailIcon)
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
        correctData(field: NameField, label: NameErrorLabel, image: NameIcon)
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
                PhoneLabel.isHidden = true
            }
        }
    }
    
    /**
     PhoneField text changing handler
     */
    
    @IBAction func phoneChanged(_ sender: Any) {
        correctData(field: PhoneField, label: PhoneErrorLabel, image: PhoneIcon)
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
     Format birth date received from server
     - Author: Egor
     - Parameters:
     - birthDate: Birth date recieved from server
     - format_from: Format of recieved date
     - format_to: Format of needed date
     - returns: Formatted string date
     */
    
    func formatBirthDate(birthDate: String, format_from: String, format_to: String) -> String {
        let formatter = DateFormatter()
        var formattedDate = "Не указана"
        formatter.dateFormat = format_from
        if let oldDate = formatter.date(from: birthDate){
            formatter.dateFormat = format_to
            formattedDate = formatter.string(from: oldDate)
        }
        
        return formattedDate
    }
    
    /**
     Save changes button tap
     */
    
    @IBAction func SaveChangesBtnTap(_ sender: UIButton) {
        EmailErrorLabel.text = "Пожалуйста, введите корректный адрес"
        dismissKeyboard()
        if let name = NameField.text, let email = EmailField.text, let phone = PhoneField.text, let date = DateField.text {
            if name != Name || phone != Phone || date != BirthDate || email != Email {
                if validateName(name: name) && validatePhone(number: phone) && validateEmail(email: email) {
                    var data: RequestChangeUserCredentials
                    if (date == "Не указана"){
                        data = RequestChangeUserCredentials(email: Email, new_email: "", code: 0, name: name, phone: phone, birthday: "")
                    } else {
                        let formattedDate = formatBirthDate(birthDate: date, format_from: "dd.MM.yyyy", format_to: "yyyy-MM-dd")
                        data = RequestChangeUserCredentials(email: Email, new_email: "", code: 0, name: name, phone: phone, birthday: formattedDate)
                    }
                    if email == Email {
                        if (!DataLoader.shared().testNetwork()){
                            self.present(Alert.shared().noInternet(protocol: self as? AlertProtocol), animated: true, completion: nil)
                        } else {
                            DataLoader.shared().changeUserCredentials(data: data){ result, error in
                                print(result.code)
                                if result.code == 200 {
                                    self.navigationController?.popViewController(animated: true)
                                    UserDefaultsData.shared().saveName(name: data.name)
                                    if (date.isEmpty){
                                        UserDefaultsData.shared().saveBirthDate(birthDate: "Не указана") 
                                    }else{
                                        UserDefaultsData.shared().saveBirthDate(birthDate: data.birthday)
                                    }
                                    UserDefaultsData.shared().savePhone(phone: data.phone)
                                }
                            }
                        }
                    }else{
                        data.new_email = email
                        data.email = Email
                        if (!DataLoader.shared().testNetwork()){
                            self.present(Alert.shared().noInternet(protocol: self as? AlertProtocol), animated: true, completion: nil)
                        } else {
                            print("verifyEmail", data.new_email)
                            Alert.shared().showSpinner(onView: self.view)
                            DataLoader.shared().findUser(email: email){ result in
                                switch result?.code {
                                case 404:
                                    DataLoader.shared().verifyEmail(data: RequestUserEmail(email: data.new_email)){ result in

                                        if result?.code == 200 {
                                            let storyboard = UIStoryboard(name: "CheckNumber", bundle: nil)
                                            let vc = storyboard.instantiateViewController(withIdentifier: "CheckNumberScreen") as! CheckNumberVC
                                            vc.requestChengeUser = data
                                            vc.isChenge = true
                                            Alert.shared().removeSpinner()
                                            self.navigationController?.pushViewController(vc, animated: true)
                                        } else {
                                        }}
                                    break
                                case 200:
                                    self.EmailErrorLabel.text = "Пользователь с такой почтой уже существует"
                                    self.incorrectData(field: self.EmailField, label: self.EmailErrorLabel, image: self.EmailIcon)
                                    Alert.shared().removeSpinner()
                                    break
                                case .none:
                                    break
                                case .some(_):
                                    break
                                }
                            }
                        }
                    }
                }
                if !validateName(name: name) {
                    incorrectData(field: NameField, label: NameErrorLabel, image: NameIcon)
                }
                if !validateEmail(email: email) {
                    incorrectData(field: EmailField, label: EmailErrorLabel, image: EmailIcon)
                }
                if !validatePhone(number: phone) {
                    incorrectData(field: PhoneField, label: PhoneErrorLabel, image: PhoneIcon)
                }
            }
        }
    }
}
