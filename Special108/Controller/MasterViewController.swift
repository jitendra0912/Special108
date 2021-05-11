//
//  MasterViewController.swift
//  Special108
//
//  Created by Jitendra on 06/05/21.
//

import UIKit

class MasterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationHelper.shared.setNavigationBarTitle("jitendra", inViewController: self)
        NavigationHelper.shared.addLeftBarButtonItems(inViewController: self, withButtonType: .backBarButtonType)
        NavigationHelper.shared.addRightBarButtons(basketView: true, showNotification: true, showSearch: false, viewController: self)
      
    
    }
    
}
