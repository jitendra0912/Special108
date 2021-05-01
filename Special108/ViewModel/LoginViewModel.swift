//
//  LoginViewModel.swift
//  Special108
//
//  Created by Jitendra on 01/05/21.
//

import UIKit

class LoginViewModel: NSObject {

    func getCountryCode()->String{
        
        let regionCode = Locale.current.regionCode ?? ""
        
        return "+" + (CountriesCode[regionCode] ?? "")
    }
   
    func getOtp(_ countryCode: String, phoneNumber:String) {
        FirebaseAuth.share.getFirebaseOTP(countryCode, phoneNumber: phoneNumber)
    }
}
