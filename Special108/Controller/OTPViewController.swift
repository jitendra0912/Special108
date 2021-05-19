//
//  OTPViewController.swift
//  Special108
//
//  Created by Jitendra on 02/05/21.
//

import UIKit
import OTPFieldView
class OTPViewController: BaseViewController {

    @IBOutlet weak var LabelTitleOTP: UILabel!
    @IBOutlet weak var buttonContinue: UIButton!
    @IBOutlet weak var buttonOTPCall: UIButton!
    @IBOutlet weak var labelOTPResend: UILabel!
    @IBOutlet weak var labelTimer: UILabel!
    var count = 60  // 60sec if you want
    var resendTimer = Timer()
    @IBOutlet weak var otpView: OTPFieldView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupOtpView()
        self.initialUI()
        self.startOTPTimer()
        self.view.backgroundColor =  ThemeManager.theme1.backgroundColor

        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.resendTimer.invalidate()
    }
    
    func setupOtpView(){
            self.otpView.fieldsCount = 6
            self.otpView.fieldBorderWidth = 2
            self.otpView.defaultBorderColor = UIColor.black
            self.otpView.filledBorderColor = UIColor.black
            self.otpView.cursorColor = UIColor.red
            self.otpView.displayType = .underlinedBottom
            self.otpView.fieldSize = 40
            self.otpView.separatorSpace = 8
            self.otpView.shouldAllowIntermediateEditing = false
           // self.otpView.delegate = self
            self.otpView.initializeUI()
    }
    private func startOTPTimer() {
         resendTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
     }
    @objc func update() {
        if(count > 0) {
            count = count - 1
            print(count)
            self.labelTimer.text = ("00:\(count)")
        }
        else {
            resendTimer.invalidate()
            print("call your api")
            // if you want to reset the time make count = 60 and resendTime.fire()
        }
    }
    
    private func AttributedOTPCallButton() {
        let underlineAttributedString = NSAttributedString(string:"Get OTP on call", attributes:[NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
          self.buttonOTPCall.setAttributedTitle(underlineAttributedString, for: .normal)
          self.buttonContinue.layer.cornerRadius = 8.0
          self.buttonContinue.clipsToBounds = true
    }
    private func AttributedOTPTitle() {
            let text = "Enter the 6-degit OTP to 7044216968"
           let attributedText = NSMutableAttributedString.getAttributedString(fromString: text)
           attributedText.apply(font: UIFont.boldSystemFont(ofSize: 16), subString: "7044216968")
           self.LabelTitleOTP.attributedText = attributedText
    }
    private func AttributedOTPResend() {
            let text = "Didn't receive the OTP? Resend"
           let attributedText = NSMutableAttributedString.getAttributedString(fromString: text)
           attributedText.apply(font: UIFont.boldSystemFont(ofSize: 16), subString: "Resend")
            attributedText.apply(color: UIColor().colorFromHexString("33A9E1"), subString: "Resend")
           self.labelOTPResend.attributedText = attributedText
    }
    private func initialUI() {
        AttributedOTPTitle()
        AttributedOTPResend()
        AttributedOTPCallButton()
       
    }
    
    @IBAction func didTapOTPCell(_ sender: UIButton) {
    }
    
    @IBAction func didTapContinue(_ sender: UIButton) {
        
        let fbTabBarController = SPTabBarController()
        
        let firstViewController = FirstVC()
        firstViewController.tabBarItem = SPTabBarItems(title: "First",
                                                      image: UIImage(systemName: "1.circle.fill"),
                                                      tag: 0,
                                                      tintColor: .systemBlue)

        let secondViewController = SecoundVC()
        secondViewController.tabBarItem = SPTabBarItems(title: "Second",
                                                       image: UIImage(systemName: "2.circle.fill"),
                                                       tag: 1,
                                                       tintColor: .systemTeal)

        let thirdViewController = ThiredVC()
        thirdViewController.tabBarItem = SPTabBarItems(title: "Third",
                                                      image: UIImage(systemName: "3.circle.fill"),
                                                      tag: 2,
                                                      tintColor: .systemRed)
        
        fbTabBarController.setViewControllers([firstViewController, secondViewController, thirdViewController], animated: true)
        
        
        
        
        
        let rootController  = dashboardStoryboard.instantiateViewController(withIdentifier:"MainNavigation") as? UINavigationController
        NavigationHelper.shared.navigationController =  rootController
      //  NavigationHelper.shared.navigationController.navigationItem.title = "sdmskmds"
        UIApplication.shared.windows.first!.rootViewController =  rootController
       
    }
}
