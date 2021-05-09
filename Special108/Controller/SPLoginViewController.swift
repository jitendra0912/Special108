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
     let MAX_LENGTH_PHONENUMBER = 10
     let ACCEPTABLE_NUMBERS     = "0123456789"
    
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var buttonCountryCode: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialUI()
        setupPagerView()
       // deactiveSubmitButton()
        model.delegate =  self
      
      }

    
    @IBAction func didTapSubmit(_ sender: UIButton) {
        
      
        let optController = mainStoryboard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController

        self.navigationController!.pushViewController(optController, animated: true)

//        return
//        guard let text = mobileNumberTextField.text, !text.isEmpty else {
//            self.view.endEditing(true)
//            return
//        }
//       model.getOtp(model.getCountryCode(), phoneNumber: self.mobileNumberTextField.text ?? "")
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
        self.view.backgroundColor = .white//UIColor(hexString: "#FFBF00")
        self.viewBGMobile.clipsToBounds = true
        self.buttonSubmit.layer.cornerRadius = 8.0
        self.buttonSubmit.clipsToBounds = true
        self.buttonCountryCode.setTitle(model.getCountryCode(), for: .normal)
    }
    private func setupPagerView() {
        let model = [PagerModel(image: #imageLiteral(resourceName: "img5")), PagerModel(image: #imageLiteral(resourceName: "img1")), PagerModel(image: #imageLiteral(resourceName: "img4"))]
        pagerView.loadPagerView(model: model)
        pagerView.isAutoScroll = true
    }
    
    private func activeSubmitButton() {
        self.buttonSubmit.isEnabled = true
        self.buttonSubmit.backgroundColor = UIColor().colorFromHexString("33A9E1")
    }
    private func deactiveSubmitButton() {
        self.buttonSubmit.isEnabled = false
        self.buttonSubmit.backgroundColor = UIColor.gray
       
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
    func format(phoneNumber: String, shouldRemoveLastDigit: Bool = false) -> String {
        guard !phoneNumber.isEmpty else { return "" }
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
        let r = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: .init(rawValue: 0), range: r, withTemplate: "")

        if number.count > 10 {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: 10)
            number = String(number[number.startIndex..<tenthDigitIndex])
            self.buttonSubmit.isEnabled = true
            self.buttonSubmit.backgroundColor = .red
        }
        else{
            self.buttonSubmit.backgroundColor = .gray
            self.buttonSubmit.isEnabled = false
        }
        return number
    }
    
}
extension SPLoginViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength: Int = textField.text!.count + string.count - range.length
        if newLength > MAX_LENGTH_PHONENUMBER {
            return false
        }
        (newLength == MAX_LENGTH_PHONENUMBER) ?  self.activeSubmitButton() : self.deactiveSubmitButton()
        return (newLength <= MAX_LENGTH_PHONENUMBER)
    }
}
// MARK:- ViewModel Deleage

extension SPLoginViewController : FirbaseOTPDelegate{
    func getOTP(verificationCode: String) {
        DispatchQueue.main.async {
            let optController = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
            NavigationHelper.shared.navigationController.pushViewController(optController, animated: true)
           // self.navigationController?.pushViewController(optController, animated: true)
            
        }
    }
    
    
}
