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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*if self.view.frame.height < 712 {
            ScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 712)
        }*/
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        SignUpBtn.layer.cornerRadius = 20
        setStyleForTextField(field: EmailField, placeholder: "E-mail")
        setStyleForTextField(field: PasswordField, placeholder: "Пароль")
        setStyleForTextField(field: NameField, placeholder: "Имя")
        setStyleForTextField(field: PhoneField, placeholder: "Телефон")
        setStyleForTextField(field: RepeatPasswordField, placeholder: "Пароль")
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

}
