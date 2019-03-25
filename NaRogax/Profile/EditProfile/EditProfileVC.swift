//
//  EditProfileVC.swift
//  NaRogax
//
//  Created by User on 25/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
    
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
    @IBOutlet weak var SignUpBtn: UIButton!
    @IBOutlet weak var NameImage: UIImageView!
    @IBOutlet weak var PhoneImage: UIImageView!
    @IBOutlet weak var EmailImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func validateName(name: String) -> Bool {
        if name.count > 1 {
            let range = NSRange(location: 0, length: name.count)
            //let reg = "^[a-zA-Zа-яА-ЯёЁ]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
            let reg = "^[A-Za-zА-Яа-яЁё]{1,\(NameField.maxLength)}$"
            let regex = try! NSRegularExpression(pattern: reg)
            if regex.firstMatch(in: name, options: [], range: range) != nil{
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    

}
