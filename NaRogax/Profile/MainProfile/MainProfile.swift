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
    
    /**
     Check if user authorized
     */
    override func viewWillAppear(_ animated: Bool) {
        if (Name.isHidden){
            Alert.shared().showSpinner(onView: self.view)
        }
        ScrollView.scrollsToTop = true
        DataLoader.shared().checkAuto(){ result in
            if result?.code != 200 {
                if (self.Name.isHidden){
                    Alert.shared().removeSpinner()
                }
                self.changeVisibility(flag: true)
                self.SignInBtn.layer.cornerRadius = 20
            } else {
                let email = UserDefaultsData.shared().getEmail()
                self.getProfileData(email: email)
            }
            Alert.shared().removeSpinner()
        }
    }
    
    /**
     Disable scroll on all screens besides like 5s
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        if view.frame.height >= 667 {
            ScrollView.isScrollEnabled = false
        }
        EditProfileBtn.layer.cornerRadius = 20
    }
    
    /**
     Change profile view. Show data if user authorized else show label and sign in button
     - Author: Egor
     - parameters:
        - flag: false if user authorized else true
     */
    
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
    
    /**
     User tap edit button. Transfer data and move to EditProfile screen
     */
    
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
    
    /**
     User tap sign out button
     */
    
    @IBAction func signOutBtnTap(_ sender: UIButton) {
        DataLoader.shared().exitLogin()
        ScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        self.viewWillAppear(false)
        self.viewDidLoad()
    }
    
    /**
     Set profile data from app memory or server
     */
    
    private func setProfileData(){
        let email = UserDefaultsData.shared().getEmail()
        let name = UserDefaultsData.shared().getName()
        let phone = UserDefaultsData.shared().getPhone()
        let birthDate = UserDefaultsData.shared().getBirthDate()
        if (name.isEmpty || phone.isEmpty || birthDate.isEmpty){
            getProfileData(email: email)
        }else{
            Name.text = name
            Phone.text = phone
            Email.text = email
            Date.text = birthDate
        } 
    }
    
    /**
     Get profile data from server
     - Author: Egor
     - parameters:
        - email: User email
     */
    
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
                    let formattedDate = self.formatBirthDate(birthDate: date, format_from: "yyyy-MM-dd", format_to: "dd.MM.yyyy")
                    self.Date.text = formattedDate
                } else {
                    self.Date.text = "Не указана"
                }
                Alert.shared().removeSpinner()
            }
        }
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
     User tap sign in button. Move to sign in screen
     */
    
    @IBAction func SignInBtnTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SignInScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignInScreen") as! SignInVC
        navigationController?.pushViewController(vc, animated: true)
    }
}
