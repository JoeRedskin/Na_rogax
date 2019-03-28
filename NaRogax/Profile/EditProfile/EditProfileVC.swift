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
    
    var Name = ""
    var Email = ""
    var Phone = ""
    var BirthDate = ""
    
    private var isEmptyName = false {
        didSet {
            if !isEmptyPhone && !isEmptyName && !isEmptyEmail && !isEmptyDate{
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
    
    private var isEmptyPhone = false {
        didSet {
            if !isEmptyPhone && !isEmptyName && !isEmptyEmail && !isEmptyDate{
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
    
    private var isEmptyEmail = false {
        didSet {
            if !isEmptyPhone && !isEmptyName && !isEmptyEmail && !isEmptyDate{
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
    
    private var isEmptyDate = false {
        didSet {
            if !isEmptyPhone && !isEmptyName && !isEmptyEmail && !isEmptyDate{
                SaveChangesBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
                SaveChangesBtn.isEnabled = true
            } else {
                SaveChangesBtn.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                SaveChangesBtn.isEnabled = false
            }
            if !isEmptyDate {
                DateLabel.isHidden = false
            } else {
                DateLabel.isHidden = true
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
        PhoneField.maxLength = 11
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
    
    @IBAction func phoneChanged(_ sender: Any) {
        correctData(field: PhoneField, label: PhoneErrorLabel, image: PhoneIcon)
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
    
    @IBAction func dateChanged(_ sender: Any) {
        //DateField.text =
    }
    
    
    @IBAction func SaveChangesBtnTap(_ sender: UIButton) {
        if let name = NameField.text, let email = EmailField.text, let phone = PhoneField.text, let date = DateField.text {
            if name != Name || phone != Phone || date != BirthDate || email != Email {
                if validateName(name: name) && validatePhone(number: phone) && validateEmail(email: email) {
                    /* TODO: Запрос на сохранение данных */
                    if email == Email {
                        var data: RequestChangeUserCredentials
                        if date == BirthDate {
                            data = RequestChangeUserCredentials(email: email, new_email: "", code: "", name: name, phone: phone, birthday: "")
                        } else {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "dd.MM.yyyy"
                            let oldDate = formatter.date(from: date)
                            formatter.dateFormat = "yyyy-MM-dd"
                            let newDate = formatter.string(from: oldDate!)
                            data = RequestChangeUserCredentials(email: email, new_email: "", code: "", name: name, phone: phone, birthday: newDate)
                        }
                        
                        if (!DataLoader.shared().testNetwork()){
                            self.present(Alert.shared().noInternet(protocol: self as? AlertProtocol), animated: true, completion: nil)
                        } else {
                            DataLoader.shared().changeUserCredentials(data: data){ result, error in
                                print(result.code)
                                if result.code == 200 {
                                    self.navigationController?.popViewController(animated: true)
                                } else {
                                    print(error)
                                    print(error?.desc ?? "")
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
