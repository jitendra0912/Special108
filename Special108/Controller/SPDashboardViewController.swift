//
//  SPDashboardViewController.swift
//  Special108
//
//  Created by Jitendra on 06/05/21.
//

import UIKit

class SPDashboardViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationConfigure()
      }
    

    @IBAction func actionMove(_ sender: UIButton) {
        let masterVC = dashboardStoryboard.instantiateViewController(withIdentifier:"MasterViewController") as! MasterViewController
        NavigationHelper.shared.navigationController.pushViewController(masterVC, animated: true)
    
    }
 }
extension SPDashboardViewController {
    private func navigationConfigure() {
        NavigationHelper.shared.setNavigationBarTitle(SPNavigationTitle.dashboardTitle, inViewController: self)
        NavigationHelper.shared.addLeftBarButtonItems(inViewController: self, withButtonType: .HeaderMenuIcon)
    }
    
    
}
