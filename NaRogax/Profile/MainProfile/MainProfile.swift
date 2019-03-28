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
        SignInBtn.isHidden = true
        SignInLabel.isHidden = true
        Alert.shared().showSpinner(onView: self.view)
        DataLoader.shared().checkAuto(){ result in
            if result?.code != 200 {
                self.changeVisibility(flag: true)
                
//                self.SignInLabel.isHidden = false
//                self.SignInBtn.isHidden = false
                self.SignInBtn.layer.cornerRadius = 20
                
                Alert.shared().removeSpinner()
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
        
//        Alert.shared().showSpinner(onView: self.view)
//        DataLoader.shared().checkAuto(){ result in
//            if result?.code != 200 {
//                self.changeVisibility(flag: true)
//
//                self.SignInLabel.isHidden = false
//                self.SignInBtn.isHidden = false
//                self.SignInBtn.layer.cornerRadius = 20
//
//                Alert.shared().removeSpinner()
//            } else {
//                let email = UserDefaultsData.shared().getEmail()
//                self.getProfileData(email: email)
//            }
//        }
        
    }
    
    func changeVisibility(flag: Bool) {
        self.Email.isHidden = flag
        self.Name.isHidden = flag
        self.Phone.isHidden = flag
        self.Date.isHidden = flag
        self.EditProfileBtn.isHidden = flag
        self.SignOutBtn.isHidden = flag
        self.SeparatorLine.isHidden = flag
        self.NameLabel.isHidden = flag
        self.PhoneLabel.isHidden = flag
        self.EmailLabel.isHidden = flag
        self.DateLabel.isHidden = flag
        self.ScrollView.isScrollEnabled = !flag
        
        self.SignInLabel.isHidden = !flag
        self.SignInBtn.isHidden = !flag
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
        DataLoader.shared().exitLogin()
        ScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        self.viewWillAppear(false)
        self.viewDidLoad()
    }
    
    func getProfileData(email: String) {
        /* TODO: Получение данных пользователя по его почте */
        let data = RequestUserEmail(email: email)
        if (!DataLoader.shared().testNetwork()){
            self.present(Alert.shared().noInternet(protocol: self as? AlertProtocol), animated: true, completion: nil)
        } else {
            DataLoader.shared().viewUserCredentials(data: data){ result, error in
                self.changeVisibility(flag: false)
                self.Name.text = result.data.name
                self.Phone.text = result.data.phone
                self.Email.text = result.data.email
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
                Alert.shared().removeSpinner()
            }
        }
    }
    
    @IBAction func SignInBtnTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SignInScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignInScreen") as! SignInVC
        navigationController?.pushViewController(vc, animated: true)
    }
}
