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
    var secondPage = SelectTableShowBookingVC()
    @IBOutlet weak var segmentedControler: UISegmentedControl!
    @IBOutlet weak var custView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentPageVCOnView()
        pageController.delegate =  self
        pageController.dataSource =  self
        
        //segmentedControl = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        segmentedControler.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        segmentedControler.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        getUUID()
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //временная
    private func start(resp: RequestUserEmail){
        firstPage = storyboard?.instantiateViewController(withIdentifier: "BookingVC") as! BookingVC
        let storyboard2 = UIStoryboard(name: "SelectTableScreen", bundle: nil)
        secondPage = storyboard2.instantiateViewController(withIdentifier: "SelectTableShowBooking") as! SelectTableShowBookingVC
        secondPage.chekAuto = resp
        pageController.setViewControllers([ firstPage], direction: .forward, animated: true, completion: nil)
    }
    
    //переписать на д.р. получении
    private func getUUID(){
        let post = RequestPostAuth(email: "zlobrynya@gmail.com",password: "test")
        let ret = RequestUserEmail(email: "zlobrynya@gmail.com")
        DataLoader.shared().authorizeUser(data: post){ result, error in
            if error?.code == 200{
                self.start(resp: ret)
            }else{
            }
        }
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
        self.pageController.view.frame = CGRect.init(x: 0, y: 0, width: custView.frame.width, height: custView.frame.height)
        self.addChild(self.pageController)
        //custView.addChild(self.pageController)
        custView.addSubview(self.pageController.view)
        self.pageController.didMove(toParent: self)
    }
    
}


extension MainBookingVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print("change viewControllerBefore", segmentedControler.selectedSegmentIndex)
        //segmentedControler.selectedSegmentIndex = 0
        if viewController == secondPage{
            print("change viewControllerBefore", segmentedControler.selectedSegmentIndex)
            segmentedControler.selectedSegmentIndex = 0
            return firstPage
        } else {
            return nil
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        print("change viewControllerAfter", segmentedControler.selectedSegmentIndex)
        //segmentedControler.selectedSegmentIndex = 1
        if viewController ==  firstPage{
            return secondPage
        } else {
            return nil
        }
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        print("finished completed", finished, completed)
        if finished {
            if completed {
                //self.finished = true
                if (segmentedControler.selectedSegmentIndex == 0){
                    segmentedControler.selectedSegmentIndex = 1
                }else{
                    segmentedControler.selectedSegmentIndex = 0
                }
            }
        }
    }
}
