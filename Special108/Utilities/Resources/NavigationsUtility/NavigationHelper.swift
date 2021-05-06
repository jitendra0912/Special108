//
//  JANavigationUtility.swift
//  Special108
//
//  Created by Jitendra on 05/05/21.
//

import UIKit
import Foundation
class NavigationHelper: NSObject{
    static let shared = NavigationHelper()
    var navigationController: UINavigationController!
    fileprivate override init() {
  
    }
  
    internal func navigateToViewController(_ isSpeciality: Bool, index: Int) {
        navigationController.popViewController(animated: true)
    }
    //MARK: Navigation Title Setup
    func setNavigationBarTitle(_ title: String?)  {
        self.navigationController.navigationItem.title = title!
    }
}
