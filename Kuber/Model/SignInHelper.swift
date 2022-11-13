//
//  SignInHelper.swift
//  Kuber
//
//  Created by Begum Sen on 14.11.2022.
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
                print("Email is verified, now you are signed in as " + userEmail)
                self.delegate?.signInTheUser()
            } else {
              // user's email is not verified
                print("Cant Sign in user. Verification needed")
                self.delegate?.giveSignInError(errorDescription: "Cant Sign in user. Verification needed")
                
            }
          }
          if let error = error {
              responseText = error.localizedDescription
              print("error in the sign in Begum")
              self.delegate?.giveSignInError(errorDescription: responseText)
              
          }
        }
         
    }
    
}


