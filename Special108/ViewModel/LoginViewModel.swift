//
//  LoginViewModel.swift
//  Special108
//
//  Created by Jitendra on 01/05/21.
//

import UIKit

protocol FirbaseOTPDelegate  {
    
    func getOTP(verificationCode: String)->()
}
class LoginViewModel: NSObject {

     var delegate: FirbaseOTPDelegate?
    func getCountryCode()->String{
        
        let regionCode = Locale.current.regionCode ?? ""
        
        return "+" + (CountriesCode[regionCode] ?? "")
    }
   
    func getOtp(_ countryCode: String, phoneNumber:String) {
        FirebaseAuth.share.getFirebaseOTP(countryCode, phoneNumber: phoneNumber) { (verificationCode) in
            guard let OTP =  verificationCode else {
                return
            }
            self.delegate?.getOTP(verificationCode: OTP)
        }
       
    }
}
