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
        
        //segmentedControl = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)+
        let font = UIFont.systemFont(ofSize: 11)
        segmentedControler.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        segmentedControler.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: font], for: UIControl.State.normal)
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
        if (sender.selectedSegmentIndex == 0){
            firstPage.view.isUserInteractionEnabled = false
            pageController.setViewControllers([firstPage], direction: .reverse, animated: true, completion: { finish in
                self.firstPage.view.isUserInteractionEnabled = true})
        }else{
            secondPage.view.isUserInteractionEnabled = false
            pageController.setViewControllers([secondPage], direction: .forward, animated: true, completion: { finish in
                self.secondPage.view.isUserInteractionEnabled = true})
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
        if viewController == secondPage{
            return firstPage
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        if viewController ==  firstPage{
            return secondPage
        } else {
            return nil
        }
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        self.segmentedControler.isUserInteractionEnabled = true
        if finished {
            if completed {
                //self.finished = true
                switch pageController.viewControllers!.first{
                case is BookingVC:
                    segmentedControler.selectedSegmentIndex = 0
                    break
                case is SelectTableShowBookingVC:
                    segmentedControler.selectedSegmentIndex = 1
                    break
                case .none:
                    break
                case .some(_):
                    break
                }
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            willTransitionTo pendingViewControllers: [UIViewController]){
        self.segmentedControler.isUserInteractionEnabled = false
    }
}
