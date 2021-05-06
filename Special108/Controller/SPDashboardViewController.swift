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

        
 //
        
       //  rootController.viewControllers = [optController]
        // NavigationManager.helper.navigationController = rootController
        
        
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func action(_ sender: UIButton) {
        let masterVC = mainStoryboard.instantiateViewController(withIdentifier:"MasterViewController") as! MasterViewController
        NavigationHelper.shared.navigationController!.pushViewController(masterVC, animated: true)
    
    
    }
}

