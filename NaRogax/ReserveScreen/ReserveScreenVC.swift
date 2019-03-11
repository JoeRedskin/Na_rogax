//
//  ReserveScreenVC.swift
//  NaRogax
//
//  Created by User on 11/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class ReserveScreenVC: UIViewController {
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var NameField: UITextField!
    
    @IBOutlet weak var PhoneLabel: UILabel!
    @IBOutlet weak var PhoneField: UITextField!
    @IBOutlet weak var PhoneImage: UIImageView!
    @IBOutlet weak var PhoneErrorLabel: UILabel!
    
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var EmailImage: UIImageView!
    @IBOutlet weak var EmailErrorLabel: UILabel!
    
    @IBOutlet weak var TableInfoLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    
    @IBOutlet weak var ReserveBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ReserveBtn.layer.cornerRadius = 20
        setStyleForTextField(field: NameField)
        setStyleForTextField(field: PhoneField)
        setStyleForTextField(field: EmailField)
    }
    
    func setStyleForTextField(field: UITextField!){
        field.layer.masksToBounds = false
        field.layer.shadowRadius = 0.0
        field.layer.shadowOpacity = 1.0
        field.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
        field.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        field.layer.borderWidth = 0.0
    }

}
