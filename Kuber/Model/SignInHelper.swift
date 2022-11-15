//
//  SignInHelper.swift
//  Kuber
//
//  Created by Begum Sen on 15.11.2022.
//

import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class SignInHelper {
    
    var delegate: SignInDelegate?
    
    func checkAndSignIn (userEmail: String, userPassword: String) {
        var responseText: String = ""
        
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { (authResult, error) in
          if let authResult = authResult {
            let user = authResult.user
            if user.isEmailVerified {
                // user can sign in
                self.delegate?.signInTheUser()
            } else {
              // user's email is not verified
                self.delegate?.giveSignInError(errorDescription: "Cant Sign in user. Verification needed")
                
            }
          }
          if let error = error {
              responseText = error.localizedDescription
              self.delegate?.giveSignInError(errorDescription: responseText)
              
          }
        }
         
    }
    
}
