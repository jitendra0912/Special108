//
//  SPTabBarController.swift
//  Special108
//
//  Created by Jitendra on 09/05/21.
//

import UIKit

class SPTabBarController: UITabBarController {

    // MARK: Properties
        
    private let indicatorPlatform = UIView()
    
    // MARK: Init
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let firstItem = tabBar.items?[0],
            let firstFBItem = firstItem as? SPTabBarItems,
            let firstFBItemColor = firstFBItem.tintColor
            else {
                return
        }
        
        tabBar.tintColor = firstFBItemColor
        indicatorPlatform.backgroundColor = firstFBItemColor
    }
    
    public func loadTabbar() {
      //  let fbTabBarController = SPTabBarController()
       
        let firstViewController = dashboardStoryboard.instantiateViewController(withIdentifier:"SPDashboardViewController") as! SPDashboardViewController
        let navgitaionController1 = UINavigationController(rootViewController: firstViewController)
        navgitaionController1.tabBarItem = SPTabBarItems(title: "First",
                                                      image: UIImage(systemName: "1.circle.fill"),
                                                      tag: 0,
                                                      tintColor: .systemBlue)

        let secondViewController = dashboardStoryboard.instantiateViewController(withIdentifier:"MasterViewController") as! MasterViewController
        let navgitaionController2 = UINavigationController(rootViewController: secondViewController)
        navgitaionController2.tabBarItem = SPTabBarItems(title: "Second",
                                                       image: UIImage(systemName: "2.circle.fill"),
                                                       tag: 1,
                                                       tintColor: .systemTeal)

        let thirdViewController = ThiredVC()
        thirdViewController.tabBarItem = SPTabBarItems(title: "Third",
                                                      image: UIImage(systemName: "3.circle.fill"),
                                                      tag: 2,
                                                      tintColor: .systemRed)
        
        self.setViewControllers([navgitaionController1, navgitaionController2, thirdViewController], animated: true)
    }
    open override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        
        setupIndicatorPlatform()
    }
    
    // MARK: UITabBarDelegate
    
    public override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = CGFloat(integerLiteral: tabBar.items!.firstIndex(of: item)!)
        let itemWidth = indicatorPlatform.frame.width
        let newCenterX = (itemWidth / 2.0) + (itemWidth * index)

        UIView.animate(withDuration: 0.3) {
            if let fbTabBarItem = item as? SPTabBarItems,
                let fbTabBarItemColor = fbTabBarItem.tintColor {
                tabBar.tintColor = fbTabBarItemColor
            }
            self.indicatorPlatform.backgroundColor = tabBar.tintColor
            self.indicatorPlatform.center.x = newCenterX
        }
    }

    // MARK: Private Functions
    
    private func setupIndicatorPlatform() {
        let tabBarItemSize = CGSize(width: tabBar.frame.width / CGFloat(tabBar.items!.count), height: tabBar.frame.height)
        indicatorPlatform.backgroundColor = tabBar.tintColor
        indicatorPlatform.frame = CGRect(x: 0.0, y: 0.0, width: tabBarItemSize.width, height: 2.0)
        indicatorPlatform.center.x = tabBar.frame.width / CGFloat(tabBar.items!.count) / 2.0
        tabBar.addSubview(indicatorPlatform)
    }

}
