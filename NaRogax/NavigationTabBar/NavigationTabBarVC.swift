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
        UIView.appearance().isExclusiveTouch = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func settingTabBar(){
        let firstViewController = UIStoryboard(name: "Main", bundle: nil)
        let vc = firstViewController.instantiateViewController(withIdentifier: "TabsViewController")
        vc.tabBarItem =  UITabBarItem(title: "Меню", image: UIImage(named: "ic_menu"), tag: 0)

        let thirdViewController = UIStoryboard(name: "BookingMain", bundle: nil)
        let thirdVC = thirdViewController.instantiateViewController(withIdentifier: "MainBooking")
        thirdVC.tabBarItem = UITabBarItem(title: "Бронь", image: UIImage(named: "ic_calendar"), tag: 1)
        
        let secondViewController = UIStoryboard(name: "MainProfile", bundle: nil)
        let secVC = secondViewController.instantiateViewController(withIdentifier: "MainProfile") as! MainProfile
        secVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "ic_profile"), tag: 2)
        
        let tabBarList = [vc, thirdVC, secVC]
        viewControllers = tabBarList
    }

}
