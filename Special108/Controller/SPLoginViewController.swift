//
//  SPLoginViewController.swift
//  Special108
//
//  Created by Jitendra on 01/05/21.
//

import UIKit

class SPLoginViewController: BaseViewController {
    private let model = LoginViewModel()

    @IBOutlet weak var pagerView: JAPagerView!
    @IBOutlet weak var viewBGMobile: UIView!
    @IBOutlet weak var buttonSubmit: UIButton!
    
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var buttonCountryCode: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialUI()
     
        setupPagerView()
      }

    @IBAction func didTapSubmit(_ sender: UIButton) {
        self.view.endEditing(true)
        model.getOtp(model.getCountryCode(), phoneNumber: self.mobileNumberTextField.text ?? "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addObserver()
    }
}
extension SPLoginViewController {
    private func initialUI() {
        self.viewBGMobile.layer.cornerRadius = 8.0
        self.viewBGMobile.layer.borderWidth = 1.0
        self.viewBGMobile.layer.borderColor = UIColor.gray.cgColor
        self.viewBGMobile.clipsToBounds = true
        self.buttonSubmit.layer.cornerRadius = 8.0
        self.buttonSubmit.clipsToBounds = true
        self.buttonCountryCode.setTitle(model.getCountryCode(), for: .normal)
    }
    private func setupPagerView() {
        let model = [PagerModel(image: #imageLiteral(resourceName: "img3")), PagerModel(image: #imageLiteral(resourceName: "img1")), PagerModel(image: #imageLiteral(resourceName: "img4"))]
        pagerView.loadPagerView(model: model)
        pagerView.isAutoScroll = true
        
    }
    private func addObserver(){
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
            NotificationCenter.default.addObserver(self, selector: #selector(SPLoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
          
              // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
            NotificationCenter.default.addObserver(self, selector: #selector(SPLoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
            
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      
      // move the root view up by the distance of keyboard height
      self.view.frame.origin.y = 0 - keyboardSize.height
    }

    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
    
}
