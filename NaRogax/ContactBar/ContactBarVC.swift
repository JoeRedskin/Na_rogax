//
//  ContactBarVC.swift
//  NaRogax
//
//  Created by User on 12/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class ContactBarVC: UIViewController {

    @IBOutlet var titleView: [UILabel]!
    @IBOutlet var textViews: [UILabel]!
    @IBOutlet weak var textInst: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyleText()
        setStyleTitle()
        
        /*
         //Говнокодно, но пока не могу понять как можно лучше вытаскивать из коллекции textview
         //1 <- label с vk
         //2 <- label c inst
        //для вк
        let tapVk = UITapGestureRecognizer(target: self, action: #selector(ContactBarVC.tapVk))
        textViews[1].isUserInteractionEnabled = true
        textViews[1].addGestureRecognizer(tapVk)
        //для инсты
        let tapInst = UITapGestureRecognizer(target: self, action: #selector(ContactBarVC.tapInstagram))
        textViews[2].isUserInteractionEnabled = true
        textViews[2].addGestureRecognizer(tapInst)
         
         */
    }
    
    @objc func tapInstagram(sender:UITapGestureRecognizer) {
        print("tap working")
        guard let url = URL(string: "https://www.instagram.com/narogah.ptz/") else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func tapVk(sender:UITapGestureRecognizer) {
        guard let url = URL(string: "https://vk.com/narogah_ptz") else { return }
        UIApplication.shared.open(url)
    }
    
    private func setStyleTitle(){
        for i in 0..<titleView.count{
            titleView[i].textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            titleView[i].font = UIFont.systemFont(ofSize: 24)
        }
    }
    
    private func setStyleText(){
        for i in 0..<textViews.count{
            textViews[i].textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
            textViews[i].font = UIFont.systemFont(ofSize: 20)
        }
    }
}
