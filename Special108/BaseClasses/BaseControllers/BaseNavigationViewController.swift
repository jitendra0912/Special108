//
//  BaseNavigationViewController.swift
//  Special108
//
//  Created by Jitendra on 08/05/21.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    //MARK: Navigation Title Setup
    func setNavigationBarTitle(_ title: String?)  {
        self.navigationItem.title = title!
    }

}
