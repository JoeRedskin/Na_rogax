//
//  MainBookingVC.swift
//  NaRogax
//
//  Created by User on 23/03/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class MainBookingVC: UIViewController {
    private var pageController: UIPageViewController!
    var arrayBookingVC = [UIViewController]()
    var firstPage = BookingVC()
    var secondPage = SelectTableShowBookingVC()
    private var reloadSegmentedControler = false

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
        start()
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //временная
    private func start(){
        firstPage = storyboard?.instantiateViewController(withIdentifier: "BookingVC") as! BookingVC
        let storyboard2 = UIStoryboard(name: "SelectTableScreen", bundle: nil)
        secondPage = storyboard2.instantiateViewController(withIdentifier: "SelectTableShowBooking") as! SelectTableShowBookingVC
        pageController.setViewControllers([ firstPage], direction: .forward, animated: true, completion: nil)
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
        custView.addSubview(self.pageController.view)
        self.pageController.didMove(toParent: self)
    }
    
}


extension MainBookingVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print("change viewControllerBefore", segmentedControler.selectedSegmentIndex)
        if (reloadSegmentedControler){
            segmentedControler.selectedSegmentIndex = 0
            reloadSegmentedControler = false
        }
        //segmentedControler.selectedSegmentIndex = 0
        if viewController == secondPage{
            print("change viewControllerBefore", segmentedControler.selectedSegmentIndex)
            segmentedControler.selectedSegmentIndex = 0
            return firstPage
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        print("change viewControllerAfter", segmentedControler.selectedSegmentIndex)
        if (reloadSegmentedControler){
            segmentedControler.selectedSegmentIndex = 1
            reloadSegmentedControler = false
        }
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
                reloadSegmentedControler = true
            }
        }
    }
}
