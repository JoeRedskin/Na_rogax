//
//  NavigationTabVC.swift
//  NaRogax
//
//  Created by User on 12/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class NavigationTabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = UIColor(displayP3Red: 0.55, green: 0.55, blue: 0.55, alpha: 1.0)
        //.barTintColor = UIColor.black
        settingTabBar()
        // Do any additional setup after loading the view.
    }

    
    private func settingTabBar(){
        let firstViewController = UIStoryboard(name: "Main", bundle: nil)
        let vc = firstViewController.instantiateViewController(withIdentifier: "Main")
        vc.tabBarItem =  UITabBarItem(title: "меню", image: UIImage(named: "ic_menu"), tag: 0)
        
        let secondViewController = UIStoryboard(name: "ContactBar", bundle: nil)
        let secVC = secondViewController.instantiateViewController(withIdentifier: "ContactBar") as! ContactBarVC
        secVC.tabBarItem = UITabBarItem(title: "контакты", image: UIImage(named: "ic_contacts"), tag: 1)
        
        /*
         let thirdViewController = UIStoryboard(name: "бронь", bundle: nil)
         let thirdVC = thirdViewController.instantiateViewController(withIdentifier: "бронь") as! броньVC
         thirdVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
         */
        
        let tabBarList = [vc, secVC /*, thirdVC*/]
        viewControllers = tabBarList
    }

}
