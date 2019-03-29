//
//  PasswordRecoveryMainVC.swift
//  NaRogax
//
//  Created by Egor on 23/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class PasswordRecoveryMainVC: UIViewController {
    
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var EmailErrorLabel: UILabel!
    @IBOutlet weak var EmailIcon: UIImageView!
    @IBOutlet weak var SendBtn: UIButton!
    
    /**
     Variable value is true when EmailField is empty.
     If one of TextFields empty then save changes button disabled.
     Show hint if EmailField is not empty
     */
    
    private var isEmptyEmail = true {
        didSet {
            if !isEmptyEmail {
                SendBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                SendBtn.isEnabled = true
                EmailLabel.isHidden = false
            } else {
                SendBtn.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
                SendBtn.isEnabled = false
                EmailLabel.isHidden = true
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
        
        SendBtn.layer.cornerRadius = 20
        EmailField.maxLength = 100
        setStyleForTextField(field: EmailField, placeholder: "E-mail")

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
     Field start editing handler
     */
    
    @IBAction func fieldStartEditing(_ sender: UITextField) {
        sender.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        sender.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    /**
     Field end editing handler
     */
    
    @IBAction func fieldEndEditing(_ sender: UITextField) {
        sender.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        sender.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
    }
    
    /**
     Show error label
     - Parameters:
        - text: Error text which will be showed
     */
    
    func showErrorLabel(text: String) {
        EmailErrorLabel.text = text
        EmailErrorLabel.isHidden = false
    }
    
    /**
     Send code to email
     */

    @IBAction func SendCodeTap(_ sender: UIButton) {
        EmailField.resignFirstResponder()
        if let email = EmailField.text {
            if email != "" {
                if validateEmail(email: email) {
                    self.SendBtn.isEnabled = false
                    if (!DataLoader.shared().testNetwork()){
                        self.present(Alert.shared().noInternet(protocol: self as? AlertProtocol), animated: true, completion: nil)
                        self.SendBtn.isEnabled = true
                    }else{
                        Alert.shared().showSpinner(onView: self.view)
                        DataLoader.shared().findUser(email: email){ result in
                            switch result?.code {
                            case 200:
                                let data = RequestUserEmail(email: email)
                                DataLoader.shared().verifyEmail(data: data){ result in
                                    if result?.code == 200 {
                                        let storyboard = UIStoryboard(name: "PasswordRecoveryNewPassword", bundle: nil)
                                        let vc = storyboard.instantiateViewController(withIdentifier: "NewPasswordScreen") as! PasswordRecoveryNewPasswordVC
                                        vc.email = email
                                        Alert.shared().removeSpinner()
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }
                                    self.SendBtn.isEnabled = true
                                }
                                break
                            case 404:
                                self.incorrectData(field: self.EmailField, label: nil, image: self.EmailIcon)
                                self.showErrorLabel(text: "Пользователя с такой почтой не существует")
                                Alert.shared().removeSpinner()
                                break
                            case .none:
                                break
                            case .some(_):
                                break
                            }
                            self.SendBtn.isEnabled = true
                        }
                    }
                } else {
                    incorrectData(field: EmailField, label: nil, image: EmailIcon)
                    showErrorLabel(text: "Пожалуйста, введите корректный адрес")
                }
            }
        }
    }
}
