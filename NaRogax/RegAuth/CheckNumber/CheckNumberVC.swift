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
}

class CheckNumberVC: UIViewController{
    private var index = 0
    private let TEXT_TITLE = "Введите код \n из E-mail сообщения"
    private let TEXT_ERROR = "Код введен не верно"
    private var requestPostRegUser = RequestPostRegUser()
    
    var email = "zlobrynya@gmail.com"
    var password = "test"
    var code = 0
    var name = "Никита"
    var surname = ""
    var birthday = ""
    var phone = "89210100389"
    
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
        requestPostRegUser = RequestPostRegUser(email: email, password: password, code: code, name: name, phone: phone)
        UITextField.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        sendCode()
    }
    
    private func checkCode(){
        print("sekector", "checkCode")
        var strCode = ""
        for item in textViews{
            strCode += item.text ?? ""
        }
        if (strCode.count == textViews.count){
            reloadButton(active: true)
            view.endEditing(true)
            code = Int(strCode)!
        }else{
            reloadButton(active: false)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func sendCode(){
        if (!DataLoader.shared().testNetwork()){
            self.present(Alert.shared().noInternet(protocol: self), animated: true, completion: nil)
        }else{
            print("regUser", requestPostRegUser)
            requestPostRegUser.code = code
            DataLoader.shared().regUser(data: requestPostRegUser){ result in
                if (result?.code == 200){
                    print("regUser", "OK")
                    self.navigationController?.popToRootViewController(animated: true)
                }else{
                    print("regUser", result)
                    self.reloadError(show: true)
                }
                // print("sendCode", result)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textViews[0].becomeFirstResponder()
    }
    
    @IBAction func touchTextView(_ sender: UITextField) {
        sender.becomeFirstResponder()
        sender.selectAll(nil)
        index = textViews.firstIndex(of: sender as! NumberTextView)!
    }
    
    @IBAction func textViewChange(_ sender: UITextField) {
        print("textViewChange")
        reloadError(show: false)
        if sender.text == "."{
            sender.text = ""
            return
        }
        if (index + 1 < textViews.count){
            //if !(textViews[index].text?.isEmpty)!{
                index += 1
                textViews[index].becomeFirstResponder()
            //}
        }else{
            view.endEditing(true)
        }
        checkCode()
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
            view.endEditing(true)
        }else{
            buttonCon.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
            buttonCon.isUserInteractionEnabled = false
        }
    }
    
    private func setCutText(messege str: String){
        for item in 0..<str.count{
            if (index >= textViews.count){
                break
            }
            let indexStr = str.index(str.startIndex, offsetBy: item)
            textViews[index].text = String(str[indexStr])
            index += 1
            if (index < textViews.count){
                textViews[index].becomeFirstResponder()
            }else{
                checkCode()
            }
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
}
