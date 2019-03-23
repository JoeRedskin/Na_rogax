//
//  MainBookingVC.swift
//  NaRogax
//
//  Created by User on 23/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class MainBookingVC: UIViewController {
    var pageController: UIPageViewController!
    var arrayBookingVC = [UIViewController]()
    var firstPage = BookingVC()
    var secondPage = ReservationConfirmedVC()

    private var currentPage = -1
    @IBOutlet weak var segmentedControler: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        presentPageVCOnView()
        pageController.delegate =  self
        pageController.dataSource =  self
        firstPage = storyboard?.instantiateViewController(withIdentifier: "BookingVC") as! BookingVC
        let storyboard2 = UIStoryboard(name: "ReservationConfirmed", bundle: nil)
        secondPage = storyboard2.instantiateViewController(withIdentifier: "ReservationConfirmed") as! ReservationConfirmedVC
        
        pageController.setViewControllers([ firstPage], direction: .forward, animated: true, completion: nil)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func getUUID{
        DataLoader.shared().
    }
    
    @IBAction func changedValue(_ sender: UISegmentedControl) {
        print("change", sender.selectedSegmentIndex)
        if (sender.selectedSegmentIndex == 0){
            pageController.setViewControllers([firstPage], direction: .reverse, animated: true, completion: nil)
        }else{
            pageController.setViewControllers([secondPage], direction: .forward, animated: true, completion: nil)
        }
    }
    
    
    func presentPageVCOnView() {
        self.pageController = storyboard?.instantiateViewController(withIdentifier: "BookintPageControl") as! PageControllerVC
        self.pageController.view.frame = CGRect.init(x: 0, y: segmentedControler.frame.maxY, width: self.view.frame.width, height: self.view.frame.height - segmentedControler.frame.maxY)
        self.addChild(self.pageController)
        self.view.addSubview(self.pageController.view)
        self.pageController.didMove(toParent: self)
    }
    
}


extension MainBookingVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print("change viewControllerBefore", segmentedControler.selectedSegmentIndex)
        segmentedControler.selectedSegmentIndex = 0
        /*
        if viewController == secondPage{
            // 2 -> 1
            print("change viewControllerBefore", segmentedControler.selectedSegmentIndex)
            segmentedControler.selectedSegmentIndex = 0
            return firstPage
        } else {
            // 0 -> end of the road
            return nil
        }*/
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        print("change viewControllerAfter", segmentedControler.selectedSegmentIndex)
        segmentedControler.selectedSegmentIndex = 1
        if viewController ==  firstPage{
            // 0 -> 1
            return secondPage
        } else {
            // 2 -> end of the road
            return nil
        }
    }
}
