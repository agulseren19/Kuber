//
//  SignUpHelper.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 10.11.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseCore
import FirebaseCore
import GoogleSignIn
import FirebaseCore
import FirebaseFirestore
class SignUpHelper{
    var delegate: SignUpDelegate?
    
    init() {
    }
    
    func createAndSaveUser(email:String,password:String){
       
   
                Auth.auth().createUser(withEmail: email,
                                       password: password) { user, error in
                    if error != nil {
                        self.delegate?.giveSignUpError(errorDescription: "You have already signed up or this email is incorrect.")
                    }
                    else {
                        if let range=email.range(of:"@"){
                            let domain=email[range.upperBound...]
                            //if user cannot sign up because of not using ku mail
                            if domain != "ku.edu.tr"{
                                self.delegate?.giveSignUpError(errorDescription: "Sign up with your KU email.")
                            }
                            //if user can sign up
                            else{
            
                                Auth.auth().currentUser?.sendEmailVerification { (error) in
                                    let db = Firestore.firestore()
                                   // var ref: DocumentReference? = nil

                            db.collection("users").document(email).setData([

                                "email": email,
                                "password": password,

                            ]) { err in

                                if let err = err {

                                    print("Error writing document: \(err)")

                                } else {

                                    print("Document successfully written!")

                                }
                            }
                            self.delegate?.signUpTheUser()
                            }
                        }
                        }
                        
                    }

                }

        }
         

    }

    

