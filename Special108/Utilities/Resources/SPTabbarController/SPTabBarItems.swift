//
//  SPTabBarItems.swift
//  Special108
//
//  Created by Jitendra on 09/05/21.
//

import UIKit

class SPTabBarItems: UITabBarItem {

    // MARK: Properties
    
    internal var tintColor: UIColor?
    
    // MARK: Init
    
    public convenience init(title: String?, image: UIImage?, tag: Int, tintColor: UIColor) {
        self.init()
        
        super.title = title
        super.image = image
        super.tag = tag
        self.tintColor = tintColor
    }
    
    public convenience init(title: String?, image: UIImage?, selectedImage: UIImage?, tintColor: UIColor)  {
        self.init()
        
        super.title = title
        super.image = image
        super.selectedImage = selectedImage
        self.tintColor = tintColor
        self.tintColor = tintColor
    }


}
