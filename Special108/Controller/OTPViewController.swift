//
//  OTPViewController.swift
//  Special108
//
//  Created by Jitendra on 02/05/21.
//

import UIKit
import OTPFieldView
class OTPViewController: BaseViewController {

    @IBOutlet weak var otpView: OTPFieldView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupOtpView()

        // Do any additional setup after loading the view.
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

}
