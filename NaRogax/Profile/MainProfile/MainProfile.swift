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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        if view.frame.height >= 667 {
            ScrollView.isScrollEnabled = false
        }
        EditProfileBtn.layer.cornerRadius = 20
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func editProfileBtnTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "EditProfile", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditProfile") as! EditProfileVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signOutBtnTap(_ sender: UIButton) {
        
    }
}
