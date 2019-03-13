//
//  NavigationTabVC.swift
//  NaRogax
//
//  Created by User on 12/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class NavigationTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = UIColor(red: CGFloat(55/255.0), green: CGFloat(55/255.0), blue: CGFloat(55/255.0), alpha: CGFloat(1.0) )
        UITabBar.appearance().tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: CGFloat(1.0) )
        //UIColor( red: CGFloat(0/255.0), green: CGFloat(110/255.0), blue: CGFloat(255/255.0), alpha: CGFloat(1.0) )
        //.barTintColor = UIColor.black
        settingTabBar()
        // Do any additional setup after loading the view.
    }

    
    private func settingTabBar(){
        let firstViewController = UIStoryboard(name: "Main", bundle: nil)
        let vc = firstViewController.instantiateViewController(withIdentifier: "Main")
        vc.tabBarItem =  UITabBarItem(title: "меню", image: UIImage(named: "ic_menu"), tag: 0)

        let thirdViewController = UIStoryboard(name: "SelectTableScreen", bundle: nil)
        let thirdVC = thirdViewController.instantiateViewController(withIdentifier: "Test")
        thirdVC.tabBarItem = UITabBarItem(title: "бронь", image: UIImage(named: "ic_calendar"), tag: 1)
        
        let secondViewController = UIStoryboard(name: "ContactBar", bundle: nil)
        let secVC = secondViewController.instantiateViewController(withIdentifier: "ContactBar") as! ContactBarVC
        let secTBI = UITabBarItem(title: "контакты", image: UIImage(named: "ic_contacts"), tag: 2)
        
        secVC.tabBarItem = secTBI
        
        let tabBarList = [vc, thirdVC, secVC]
        viewControllers = tabBarList
    }

}
