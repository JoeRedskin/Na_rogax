//
//  ContactBarVC.swift
//  NaRogax
//
//  Created by User on 12/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class MainProfile: UIViewController {
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var EditProfileBtn: UIButton!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var Phone: UILabel!
    @IBOutlet weak var SeparatorLine: UIView!
    @IBOutlet weak var SignInLabel: UILabel!
    @IBOutlet weak var SignInBtn: UIButton!
    @IBOutlet weak var SignOutBtn: UIButton!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var PhoneLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        DataLoader.shared().checkAuto(){ result in
            if result?.code != 200 {
                self.Email.isHidden = true
                self.Name.isHidden = true
                self.Phone.isHidden = true
                self.Date.isHidden = true
                self.EditProfileBtn.isHidden = true
                self.SignOutBtn.isHidden = true
                self.SeparatorLine.isHidden = true
                self.NameLabel.isHidden = true
                self.PhoneLabel.isHidden = true
                self.EmailLabel.isHidden = true
                self.DateLabel.isHidden = true
                self.ScrollView.isScrollEnabled = false
                
                self.SignInLabel.isHidden = false
                self.SignInBtn.isHidden = false
                self.SignInBtn.layer.cornerRadius = 20
            } else {
                let email = UserDefaultsData.shared().getEmail()
                self.getProfileData(email: email)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        if view.frame.height >= 667 {
            ScrollView.isScrollEnabled = false
        }
        EditProfileBtn.layer.cornerRadius = 20
        
//        DataLoader.shared().checkAuto(){ result in
//            if result?.code != 200 {
//                print("Not auth")
//                self.Email.isHidden = true
//                self.Name.isHidden = true
//                self.Phone.isHidden = true
//                self.Date.isHidden = true
//                self.EditProfileBtn.isHidden = true
//                self.SignOutBtn.isHidden = true
//                self.SeparatorLine.isHidden = true
//                self.NameLabel.isHidden = true
//                self.PhoneLabel.isHidden = true
//                self.EmailLabel.isHidden = true
//                self.DateLabel.isHidden = true
//                self.ScrollView.isScrollEnabled = false
//
//                self.SignInLabel.isHidden = false
//                self.SignInBtn.isHidden = false
//                self.SignInBtn.layer.cornerRadius = 20
//            } else {
//                let email = UserDefaultsData.shared().getEmail()
//                self.getProfileData(email: email)
//            }
//        }
        
//        if email == "" {
//            Email.isHidden = true
//            Name.isHidden = true
//            Phone.isHidden = true
//            Date.isHidden = true
//            EditProfileBtn.isHidden = true
//            SignOutBtn.isHidden = true
//            SeparatorLine.isHidden = true
//            NameLabel.isHidden = true
//            PhoneLabel.isHidden = true
//            EmailLabel.isHidden = true
//            DateLabel.isHidden = true
//            ScrollView.isScrollEnabled = false
//            
//            SignInLabel.isHidden = false
//            SignInBtn.isHidden = false
//            SignInBtn.layer.cornerRadius = 20
//        } else {
//            getProfileData(email: email)
//        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func editProfileBtnTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "EditProfile", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditProfile") as! EditProfileVC
        
        if let date = Date.text {
            vc.BirthDate = date
        } else {
            vc.BirthDate = "Не указана"
        }
        
        if let name = Name.text {
            vc.Name = name
        }
        
        if let email = Email.text {
            vc.Email = email
        }
        
        if let phone = Phone.text {
            vc.Phone = phone
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signOutBtnTap(_ sender: UIButton) {
        
    }
    
    func getProfileData(email: String) {
        /* TODO: Получение данных пользователя по его почте */
        let data = RequestUserEmail(email: email)
        if (!DataLoader.shared().testNetwork()){
            self.present(Alert.shared().noInternet(protocol: self as? AlertProtocol), animated: true, completion: nil)
        } else {
            DataLoader.shared().viewUserCredentials(data: data){ result, error in
                self.Name.text = result.data.name
                self.Phone.text = result.data.phone
                self.Email.text = result.data.email
                /*if result.data.birthday == "" {
                    self.Date.text = "Не указана"
                    print("No date")
                } else {
                    self.Date.text = result.data.birthday ?? <#default value#> + "kek"
                }*/
                //self.Date.text = result.data.birthday ?? "Не указана"
                if let date = result.data.birthday {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    let oldDate = formatter.date(from: date)
                    formatter.dateFormat = "dd.MM.yyyy"
                    let newDate = formatter.string(from: oldDate!)
                    
                    self.Date.text = newDate
                } else {
                    self.Date.text = "Не указана"
                }
            }
        }
    }
    
    @IBAction func SignInBtnTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SignInScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignInScreen") as! SignInVC
        navigationController?.pushViewController(vc, animated: true)
    }
}
