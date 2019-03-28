//
//  MenuBarViewController.swift
//  NaRogax
//
//  Created by User on 21/02/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//
import UIKit

class TabsVC: UIViewController {
    
    @IBOutlet weak var menuBarView: MenuTabsView!
    
    var currentIndex: Int = 0
    var tabs: [String] = []
    var pageController: UIPageViewController!
    private var finished = false
    private var dish = ResponseDishesList(categories: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alert.shared().showSpinner(onView: self.view)
        if (!DataLoader.shared().testNetwork()) {
            self.present(Alert.shared().noInternet(protocol: self), animated: true, completion: nil)
        } else {
            DataLoader.shared().getDishes(){result, error in
                if error?.code == 200 {
                    //let items = result.categories.sorted(by: { $0.order < $1.order})
                    self.dish = result
                    for tab in result.categories{
                        self.tabs += [tab.cat_name]
                    }
                    self.menuBarView.dataArray = self.tabs
                    self.menuBarView.isSizeToFitCellsNeeded = true
                    
                    self.presentPageVCOnView()
                    
                    self.menuBarView.menuDelegate = self
                    self.pageController.delegate =  self
                    self.pageController.dataSource =  self
                    
                    //For Intial Display
                    self.menuBarView.collView.selectItem(at: IndexPath.init(item: 0, section: 0), animated: true, scrollPosition: .centeredVertically)
                    self.pageController.setViewControllers([self.viewController(At: 0)!], direction: .forward, animated: true, completion: nil)
                    Alert.shared().removeSpinner()
                } else{
                    self.present(Alert.shared().couldServerDown(protocol: self), animated: true, completion: nil)
                }
                
            }
        }
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /*
     Reload view. If user tap ok button on alert with bad internet connection.
     */
    func reloadViewFromNib() {
        self.viewDidLoad()
    }
    
    func presentPageVCOnView() {
        self.pageController = storyboard?.instantiateViewController(withIdentifier: "PageControllerVC") as! PageControllerVC
        self.pageController.view.frame = CGRect.init(x: 0, y: menuBarView.frame.maxY, width: self.view.frame.width, height: self.view.frame.height - menuBarView.frame.maxY)
        self.addChild(self.pageController)
        self.view.addSubview(self.pageController.view)
        self.pageController.didMove(toParent: self)
    }
    
    //Present ViewController At The Given Index
    func viewController(At index: Int) -> UIViewController? {
        if((self.menuBarView.dataArray.count == 0) || (index >= self.menuBarView.dataArray.count)) {return nil}
        let menuVC = storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! ViewController
        menuVC.pageIndex = index
        menuVC.dishes = dish.categories[index]
        return menuVC
    }
}

extension TabsVC: AlertProtocol{
    func clickButtonPositiv(status: Int) {
        print("TabsVC")
        self.reloadViewFromNib()
    }
    
    func clickButtonCanсel(status: Int) {
        
    }
}

extension TabsVC: MenuBarDelegate {
    
    func menuBarDidSelectItemAt(menu: MenuTabsView, index: Int) {
        print(index)
        print(currentIndex)
        // If selected Index is other than Selected one, by comparing with current index, page controller goes either forward or backward.
        if index != currentIndex {
            if index > currentIndex {
                self.pageController.setViewControllers([viewController(At: index)!], direction: .forward, animated: true, completion: nil)
            } else {
                self.pageController.setViewControllers([viewController(At: index)!], direction: .reverse, animated: true, completion: nil)
            }
            menuBarView.collView.scrollToItem(at: IndexPath.init(item: index, section: 0), at: .centeredHorizontally, animated: true)
        }
        currentIndex = index
    }
}

extension TabsVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ViewController).pageIndex
        if (index == 0) || (index == NSNotFound) {return nil}
        index -= 1
        return self.viewController(At: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ViewController).pageIndex
        print("pageViewController", index)
        if (index == tabs.count) || (index == NSNotFound) {return nil}
        index += 1
        return self.viewController(At: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        print("finished completed", finished, completed)
        if finished {
            if completed {
                //self.finished = true
                let cvc = pageViewController.viewControllers!.first as! ViewController
                let newIndex = cvc.pageIndex
                currentIndex = newIndex
                menuBarView.collView.selectItem(at: IndexPath.init(item: newIndex, section: 0), animated: true, scrollPosition: .centeredVertically)
                menuBarView.collView.scrollToItem(at: IndexPath.init(item: newIndex, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
}
