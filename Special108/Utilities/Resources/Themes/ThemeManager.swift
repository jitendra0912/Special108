//
//  Themes.swift
//  Special108
//
//  Created by Jitendra on 09/05/21.
//

import UIKit
import Foundation


enum ThemeManager: Int {

    case theme1, theme2

    var mainColor: UIColor {
        switch self {
        case .theme1:
            return UIColor().colorFromHexString("ffffff")
        case .theme2:
            return UIColor().colorFromHexString("000000")
        }
    }

    //Customizing the Navigation Bar
    var barStyle: UIBarStyle {
        switch self {
        case .theme1:
            return .default
        case .theme2:
            return .black
        }
    }

    var navigationBackgroundImage: UIImage? {
        return self == .theme1 ? UIImage(named: "navBackground") : nil
    }

    var tabBarBackgroundImage: UIImage? {
        return self == .theme1 ? UIImage(named: "tabBarBackground") : nil
    }
    var navigationBarColor: UIColor {
        switch self {
        case .theme1:
            return UIColor().colorFromHexString("6EA651")
        case .theme2:
            return UIColor().colorFromHexString("000000")
        }
    }
    var backgroundColor: UIColor {
        switch self {
        case .theme1:
            return UIColor().colorFromHexString("ffffff")
        case .theme2:
            return UIColor().colorFromHexString("000000")
        }
    }

    var secondaryColor: UIColor {
        switch self {
        case .theme1:
            return UIColor().colorFromHexString("ffffff")
        case .theme2:
            return UIColor().colorFromHexString("000000")
        }
    }
    
    var titleTextColor: UIColor {
        switch self {
        case .theme1:
            return UIColor().colorFromHexString("ffffff")
        case .theme2:
            return UIColor().colorFromHexString("000000")
        }
    }
    var subtitleTextColor: UIColor {
        switch self {
        case .theme1:
            return UIColor().colorFromHexString("ffffff")
        case .theme2:
            return UIColor().colorFromHexString("000000")
        }
    }
}


