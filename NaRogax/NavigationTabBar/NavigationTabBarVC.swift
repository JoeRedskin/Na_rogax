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
        settingTabBar()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func settingTabBar(){
        let firstViewController = UIStoryboard(name: "Main", bundle: nil)
        let vc = firstViewController.instantiateViewController(withIdentifier: "TabsViewController")
        vc.tabBarItem =  UITabBarItem(title: "меню", image: UIImage(named: "ic_menu"), tag: 0)

        let thirdViewController = UIStoryboard(name: "BookingMain", bundle: nil)
        let thirdVC = thirdViewController.instantiateViewController(withIdentifier: "BookingVC")
        thirdVC.tabBarItem = UITabBarItem(title: "бронь", image: UIImage(named: "ic_calendar"), tag: 1)
        
        let secondViewController = UIStoryboard(name: "ContactBar", bundle: nil)
        let secVC = secondViewController.instantiateViewController(withIdentifier: "ContactBar") as! ContactBarVC
        secVC.tabBarItem = UITabBarItem(title: "контакты", image: UIImage(named: "ic_contacts"), tag: 2)
        
        let tabBarList = [vc, thirdVC, secVC]
        viewControllers = tabBarList
    }

}
