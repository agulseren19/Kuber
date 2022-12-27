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
                self.createTheUser(userEmail: userEmail) //FLAG
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
    
    func createTheUser (userEmail: String) {
        
        var user = User.sharedInstance
        
         let db = Firestore.firestore()
         let docRef = db.collection("users").document(userEmail)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                user.setEmail(email: userEmail)
                user.setFullName(fullName: document.get("fullName")! as! String)
                user.setMajor(major: document.get("major") as! String)
                user.setNoSmokingPreference(noSmokingPreference: document.get("smokingFlag") as! Bool)
                user.setClassLevel(classLevel: document.get("classLevel") as! String)
                user.setPhoneNumber(phoneNumber: document.get("phoneNumber") as! String)
                user.setRidesArray(ridesArray: document.data()!["publishedRides"]! as! [String])
                user.setMyHitchesArray(myHitchesArray: document.data()!["myHitches"]! as! [String])
                user.setProfilePictureUrl(profilePictureUrl: document.get("profileImageUrl") as! String)
                // set the silentRide and noSmoking
                print("user is created")
                self.delegate?.signInTheUser()
            } else {
                print("Document does not exist")
            }
        }
    }
    
}
