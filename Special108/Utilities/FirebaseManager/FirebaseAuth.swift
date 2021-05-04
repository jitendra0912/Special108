//
//  FirebaseAuth.swift
//  Special108
//
//  Created by Jitendra on 01/05/21.
//

import Foundation
import FirebaseAuth

class FirebaseAuth: NSObject {
 
    static var share = FirebaseAuth()
    var currentVerificationId: String?
    fileprivate override init() {}
    
    public func getFirebaseOTP(_ countryCode: String, phoneNumber:String, success:@escaping (_ verificationCode:String?)->()) {
        // enabling testing code...
        // disable when you need to test with real device...
        
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        
        let number = "\(countryCode)\(phoneNumber)"
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (verificationID, err) in
            
            if let error = err{
                print("eror: \(String(describing: error.localizedDescription))")
                return
            }
            success(verificationID ?? "")
            self.currentVerificationId =  verificationID ?? ""
        }
    }
    public func verifyFirebaseOTPCode(_ OTPCode:String) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.currentVerificationId ?? "", verificationCode: OTPCode)

        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            let authError = error as NSError
            print(authError.description)
            return
          }
        // else user logged in Successfully ....
        let currentUserInstance = Auth.auth().currentUser
        print(currentUserInstance)
    }
}
    
}
