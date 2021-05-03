//
//  JAAlert.swift
//  Special108
//
//  Created by Jitendra on 03/05/21.
//

import Foundation
import UIKit

public enum JAAlertControllerStyle : Int {
    
    case actionSheet
    case alert
}

public enum JAAlertActionStyle : Int {
    
    case `default`
    case cancel
    case destructive
}

open class JAAlertAction {
    
    fileprivate var handler : ((JAAlertAction) -> Void)?
    
    open var title: String?
    open var style: JAAlertActionStyle
    open var enabled: Bool = true
    
    public init() {
        self.style = .default
    }
    
    public convenience init(title: String?, style: JAAlertActionStyle, handler: ((JAAlertAction) -> Void)?) {
       self.init()
        self.title = title
        self.style = style
        self.handler = handler
    }
    
    fileprivate func invokeHandler(){
        if self.handler != nil {
            self.handler!(self)
        }
    }
    
    internal func getUIAlertAction() -> UIAlertAction {
        return UIAlertAction(title: self.title, style: UIAlertAction.Style(rawValue: self.style.rawValue)!, handler: {(alertAction) -> Void  in
            self.invokeHandler()
        })
    }
}

open class McDAlertController {
    fileprivate var message: String?
    fileprivate var title: String?
    fileprivate var style : JAAlertControllerStyle
    fileprivate var actions = [JAAlertAction]()
    
    public init() {
        self.style = .alert
    }
    
    public convenience init(title atitle: String?,
        message amessage: String?, preferredStyle astyle: JAAlertControllerStyle) {
            self.init()
            self.message = amessage
            self.title = atitle
            self.style = astyle
    }
    
    open func addAction(_ action: JAAlertAction) {
        self.actions.append(action)
    }
    
    open func presentIn(_ viewController: UIViewController, animated: Bool, completion: (()->Void)?) {
        let alertController = UIAlertController(title: self.title, message: self.message, preferredStyle: UIAlertController.Style(rawValue: self.style.rawValue)!)
        for action in actions {
            alertController.addAction(action.getUIAlertAction())
        }
        viewController.present(alertController, animated: animated, completion: completion)
    }
    
    open class func showAlertMessage(_ message : String, title : String, onViewController viewController:UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "common_ok", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
