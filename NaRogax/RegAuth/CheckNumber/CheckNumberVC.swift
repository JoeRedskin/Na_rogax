//
//  CheckNumberVC.swift
//  NaRogax
//
//  Created by User on 22/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

protocol CutPasteProtocol {
    func setText()
    func deleteBackward()
}

class CheckNumberVC: UIViewController{
    private var index = 0
    private let TEXT_TITLE = "Введите код \n из E-mail сообщения"
    private let TEXT_ERROR = "Код введен не верно"
    private var requestPostRegUser = RequestPostRegUser()
    var requestChengeUser = RequestChangeUserCredentials()
    
    var email = ""
    var password = ""
    var code = 0
    var name = ""
    var surname = ""
    var birthday = ""
    var phone = ""
    var isChenge = false
    
    @IBOutlet weak var buttonCon: UIButton!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet var textViews: [NumberTextView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTitle.text = TEXT_TITLE
        labelError.text = TEXT_ERROR
        for item in 0..<textViews.count{
            textViews[item].cutPasteProt = self
            textViews[item].setBottomLine()
        }
        reloadButton(active: false)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        UITextField.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.setNeedsStatusBarAppearanceUpdate()
        if !isChenge{
            requestPostRegUser = RequestPostRegUser(email: email, password: password, code: code, name: name, phone: phone)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        sendCode()
    }
    
    private func checkCode(){
        var strCode = ""
        for item in textViews{
            strCode += item.text ?? ""
        }
        if (strCode.count == textViews.count){
            reloadButton(active: true)
            code = Int(strCode)!
        }else{
            reloadButton(active: false)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func sendCode(){
        if isChenge{
            sendChange()
        }else{
            sendReg()
        }
    }
    
    private func sendChange(){
        if (!DataLoader.shared().testNetwork()){
            self.present(Alert.shared().noInternet(protocol: self as? AlertProtocol), animated: true, completion: nil)
        } else {
            requestChengeUser.code = code
            print(requestChengeUser)
            DataLoader.shared().changeUserCredentials(data: requestChengeUser){ result, error in
                //UserDefaultsData.shared().saveEmail(email: result.email ?? self.requestChengeUser.email)
                //UserDefaultsData.shared().saveName(name: self.name)
                print(result.code)
                if result.code == 200 {
                    UserDefaultsData.shared().saveEmail(email: result.email ?? self.requestChengeUser.email)
                    UserDefaultsData.shared().saveName(name: self.name)
                    UserDefaultsData.shared().savePhone(phone: self.requestChengeUser.phone)
                    UserDefaultsData.shared().saveBirthDate(birthDate: self.requestChengeUser.birthday)
                    self.navigationController?.popViewController(animated: true)
                } else{
                    self.reloadError(show: true)
                }
            }
        }
    }
    
    private func sendReg(){
        if (!DataLoader.shared().testNetwork()){
            self.present(Alert.shared().noInternet(protocol: self), animated: true, completion: nil)
        }else{
            requestPostRegUser.code = code
            DataLoader.shared().regUser(data: requestPostRegUser){ result, error in
                if (error?.code == 200){
                    UserDefaultsData.shared().saveEmail(email: result?.email ?? self.email)
                    UserDefaultsData.shared().saveName(name: self.name)
                    for vcIndex in 0..<self.navigationController!.viewControllers.count{
                        if let view = self.navigationController?.viewControllers[vcIndex]{
                            switch view{
                            case is SelectTableVC: self.navigationController?.popToViewController(self.navigationController!.viewControllers[vcIndex] as! SelectTableVC, animated: true)
                                self.dismiss(animated: true)
                                break
                            case is SelectTableShowBookingVC:
                                self.navigationController?.popToRootViewController(animated: true)
                                self.dismiss(animated: true)
                                break
                            default:
                                self.navigationController?.popToRootViewController(animated: true)
                                break
                            }
                        }
                    }
                }else{
                    self.reloadError(show: true)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textViews[0].becomeFirstResponder()
    }
    
    @IBAction func touchTextView(_ sender: UITextField) {
        index = textViews.firstIndex(of: sender as! NumberTextView)!
        textViews[index].becomeFirstResponder()
        textViews[index].selectAll(nil)
    }
    
    @IBAction func textViewChange(_ sender: UITextField) {
        reloadError(show: false)
        if sender.text == "."{
            sender.text = ""
            return
        }
        if (index + 1 < textViews.count){
            index += 1
            textViews[index].becomeFirstResponder()
        }else{
            view.endEditing(true)
        }
        checkCode()
    }
    
    private func back(){
        index -= 1
        if (index >= 0){
            textViews[index].becomeFirstResponder()
        }else{
            view.endEditing(true)
        }
    }
    
    private func reloadError(show: Bool){
        print("reloadError", show)
        var color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if (show){
            color = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 0.7)
            labelError.isHidden = false
        }else{
            labelError.isHidden = true
        }
        
        for item in textViews{
            item.textColor = color
        }
    }
    
    private func reloadButton(active: Bool){
        if (active){
            buttonCon.backgroundColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
            buttonCon.isUserInteractionEnabled = true
        }else{
            buttonCon.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
            buttonCon.isUserInteractionEnabled = false
        }
    }
    
    private func setCutText(messege str: String){
        for item in 0..<str.count{
            reloadError(show: false)
            if (index >= textViews.count){
                break
            }
            let indexStr = str.index(str.startIndex, offsetBy: item)
            textViews[index].text = String(str[indexStr])
            index += 1
            if (index < textViews.count){
                textViews[index].becomeFirstResponder()
            }
            checkCode()
        }
    }
}

extension CheckNumberVC: AlertProtocol{
    func clickButtonPositiv(status: Int) {
        sendCode()
    }
    
    func clickButtonCanсel(status: Int) {
        
    }
}

extension CheckNumberVC:CutPasteProtocol{
    func setText() {
        if let myString = UIPasteboard.general.string {
            if myString.count <= 5 && !myString.isEmpty{
                let range = NSRange(location: 0, length: myString.count)
                let reg = "^[0-9]"
                let regex = try! NSRegularExpression(pattern: reg)
                if regex.firstMatch(in: myString, options: [], range: range) != nil{
                    self.setCutText(messege: myString)
                }
            }
        }
    }
    
    func deleteBackward() {
        back()
    }
}

