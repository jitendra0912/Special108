//
//  JANavigationUtility.swift
//  Special108
//
//  Created by Jitendra on 05/05/21.
//

import UIKit
import Foundation
import Foundation
import UIKit


public enum  LeftBarButtonType : String {
    case closeBarButtonType = "CloseIcon"
    case backBarButtonType = "HeaderBackIcon"
    case HeaderMenuIcon =  "HeaderMenuIcon"
    
    func updateLeftBarButton () {}
}
public enum RightBarButtonType : String {
    case notificationBarButton = "HeaderNotificationIcon"
    case basketBarButton = "HeaderCartIcon"
    case searchBarButton =  "HeaderSearchIcon"
    
    func getImage()->UIImage {
        switch self {
        case .basketBarButton:
            return UIImage(named:RightBarButtonType.basketBarButton.rawValue) ?? UIImage()
        case .notificationBarButton:
            return UIImage(named:RightBarButtonType.notificationBarButton.rawValue) ?? UIImage()
        case .searchBarButton:
            return UIImage(named:RightBarButtonType.searchBarButton.rawValue) ?? UIImage()
        
        default:
            return UIImage()
        }
        
    }
}

class NavigationHelper: NSObject{
    static let shared = NavigationHelper()
    var navigationController: UINavigationController!
    fileprivate var notificationBarButton: UIBarButtonItem?
    fileprivate var basketBarButton: UIBarButtonItem?
    fileprivate var searchBarButton: UIBarButtonItem?
    let barButtonHeight:CGFloat = IS_IPAD() ? 31.0 :22.0
    
    fileprivate override init() {
        super.init()
        self.configurNavigationView()
    }
    open var isHideNavigationController: Bool = false {
        didSet {
            self.hideNavigationController()
        }
    }
 
    
    internal func navigateToViewController(_ isSpeciality: Bool, index: Int) {
        navigationController.popViewController(animated: true)
    }
    
    
    private func configurNavigationView() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(ciImage: .white), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = ThemeManager.theme1.navigationBarColor
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    /// Set basket button with custom view.
    ///
    /// - Parameters:
    ///   - target: target **AnyObject**
    ///   - action: action **Selector**
    fileprivate func setBasketButton(_ target: AnyObject, action: Selector) {
        let frame = CGRect(x: 0, y: 0, width: barButtonHeight, height: barButtonHeight)
        /// Set Basket View.
        let aView = UIView(frame: frame)
        
        /// Set basket image
        let ImageView = UIImageView(frame: aView.frame)
        ImageView.contentMode = .scaleAspectFit
        ImageView.image = RightBarButtonType.basketBarButton.getImage()
        aView.addSubview(ImageView)
        
        /// Set Bar Button.
        let aButton = UIButton(type: .custom)
        aButton.frame = aView.frame
        aButton.addTarget(target, action: action, for: .touchUpInside)
        aView.addSubview(aButton)
        
        /// Set Bar Button.
        self.basketBarButton = UIBarButtonItem(customView: aView)
        self.basketBarButton?.style = .plain
       
    }
    
    /// Set basket error button
    ///
    /// - Parameters:
    ///   - target: target **AnyObject**
    ///   - action: action **Selector**
    fileprivate func setNotificationButton(_ target: AnyObject, action: Selector) {
        let frame = CGRect(x: 0, y: 0, width: barButtonHeight, height: barButtonHeight)
        /// Set Basket View.
        let aView = UIView(frame: frame)
        
        /// Set basket image
        let ImageView = UIImageView(frame: aView.frame)
        ImageView.contentMode = .scaleAspectFit
        ImageView.image = RightBarButtonType.notificationBarButton.getImage()
        aView.addSubview(ImageView)
        
        /// Set Bar Button.
        let aButton = UIButton(type: .custom)
        aButton.frame = aView.frame
        aButton.addTarget(target, action: action, for: .touchUpInside)
        aView.addSubview(aButton)
        
        /// Set Bar Button.
        self.notificationBarButton = UIBarButtonItem(customView: aView)
        self.notificationBarButton?.style = .plain
    }
    
    fileprivate func setSearchButton(_ target: AnyObject, action: Selector) {
        let frame = CGRect(x: 0, y: 0, width: barButtonHeight, height: barButtonHeight)
        /// Set Basket View.
        let aView = UIView(frame: frame)
        
        /// Set basket image
        let ImageView = UIImageView(frame: aView.frame)
        ImageView.contentMode = .scaleAspectFit
        ImageView.image = RightBarButtonType.searchBarButton.getImage()
        aView.addSubview(ImageView)
        
        /// Set Bar Button.
        let aButton = UIButton(type: .custom)
        aButton.frame = aView.frame
        aButton.addTarget(target, action: action, for: .touchUpInside)
        aView.addSubview(aButton)
        
        /// Set Bar Button.
        self.searchBarButton = UIBarButtonItem(customView: aView)
        self.searchBarButton?.style = .plain
    }
    //MARK: Navigation Title Setup
    func setNavigationBarTitle(_ title: String?,inViewController viewController: UIViewController)  {
        viewController.navigationItem.title = title!
    }
   
    private func hideNavigationController() {
        navigationController.setNavigationBarHidden(true, animated: true)
    }
   
    open func addLeftBarButtonItems(inViewController viewController: UIViewController, withButtonType buttonType: LeftBarButtonType, targetViewController: Any? = nil, withCustomBackAction backAction:  Selector? = nil) {
        let targetController = (backAction != nil) ? (viewController as Any) : (self as Any)
        var selector: Selector? = nil
        let barImage = UIImage(named:buttonType.rawValue)?.withRenderingMode(.alwaysOriginal)
        
        switch buttonType {
       case .closeBarButtonType, .backBarButtonType:
            selector = backAction ?? (#selector(NavigationHelper.handleDismiss(_:)))
        case .HeaderMenuIcon:
            selector = backAction ?? (#selector(NavigationHelper.handleMenu(_:)))
        default:
            selector = backAction ?? (#selector(NavigationHelper.handleMenu(_:)))
        }
    
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: barImage, style: UIBarButtonItem.Style.plain, target: targetController, action: selector)
        }
    open func addRightBarButtons(basketView showBasket: Bool, showNotification: Bool, showSearch: Bool, viewController: UIViewController?,targetViewController: Any? = nil, withCustomBackAction backAction:  Selector? = nil) {
       
        if showBasket {
            setBasketButton(targetViewController as AnyObject, action: backAction ?? Selector(("buttonTapped")))
        }
        if showSearch {
            setSearchButton(targetViewController as AnyObject, action: backAction ?? Selector(("buttonTapped")))
        }
        if showNotification {
           setNotificationButton(targetViewController as AnyObject, action: backAction ?? Selector(("buttonTapped")))
        }
        
        
        let rightBarButtons: [UIBarButtonItem] = self.rightBarButtons(forBasketView: showBasket, forNotification: showNotification, forSearch: showSearch,targetViewController: targetViewController,withCustomBackAction: backAction)
        viewController?.navigationItem.setRightBarButtonItems(rightBarButtons, animated: true)
       
        if rightBarButtons.isEmpty {
            viewController?.navigationItem.setRightBarButton(nil, animated: true)
        }
    }
    
    /**
     This method sets the right bar buttons array based on the the visible status of basket, price and error icon.
     - parameter forBasketView: true if basket need to be shown
     - parameter forPrice: true if price need to be shown
     - parameter forError: true if error icon need to be shown
     - returns: an array of eligible right bar buttons
     */
    fileprivate func rightBarButtons(forBasketView showBasket: Bool, forNotification showNotification: Bool, forSearch showSearchIcon: Bool,targetViewController: Any? = nil, withCustomBackAction backAction:  Selector? = nil) -> [UIBarButtonItem] {
        var rightBarButtons: [UIBarButtonItem] = []
       
        if let basketButton = self.basketBarButton, showBasket {
           (basketButton.customView?.subviews.first as? UIImageView)?.image =  RightBarButtonType.basketBarButton.getImage().withRenderingMode(.alwaysOriginal)
            rightBarButtons.append(basketButton)
        }
        
        if let notificationButton = self.notificationBarButton, showNotification {
            (notificationButton.customView?.subviews.first as? UIImageView)?.image =  RightBarButtonType.notificationBarButton.getImage().withRenderingMode(.alwaysOriginal)
            rightBarButtons.append(notificationButton)
        }
        
        if let searchButton = self.searchBarButton, showSearchIcon {
            (searchButton.customView?.subviews.first as? UIImageView)?.image =  RightBarButtonType.searchBarButton.getImage().withRenderingMode(.alwaysOriginal)
            rightBarButtons.append(searchButton)
        }
        return rightBarButtons
    }

    //MARK: - Nav Bar Button Action
    @objc internal func handleDismiss(_ sender: UIBarButtonItem) {
        navigationController.popViewController(animated: true)
        debugPrint("Dissmiss Action")
    }
    @objc internal func handleMenu(_ sender: UIBarButtonItem) {
        debugPrint("Menu Action")
    }
}

