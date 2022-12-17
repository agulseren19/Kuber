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
import FirebaseStorage

class SignUpHelper{
    var delegate: SignUpDelegate?
    private let storage = Storage.storage().reference()
    
    init() {
    }
    
    func setImageUrl(email: String, imageData: Data){
        
        storage.child("images/_\(email)_.png").putData(imageData, metadata: nil, completion: { _, error in
            guard error == nil else {
                print("failed")
                print(error)
                return
            }
            self.storage.child("images/_\(email)_.png").downloadURL(completion: { url, error in
                guard let url = url, error == nil else{
                    return
                }
                let urlString = url.absoluteString
                let db = Firestore.firestore()
                let id = db.collection("users").document().documentID;
                db.collection("users").document(email).updateData(["profileImageUrl" : urlString ]){ err in
                    
                    if let err = err {
                        
                        print("Error writing publish data: \(err)")
                        
                    } else {
                        print("succesfull")
                        //self.delegate?.rideRequestListLoaded()
                    }
                }
                print("downloaded: \(urlString)")
            })
        })
    }
    
    func createAndSaveUser(email:String,password:String,profileImageUrl:String){
       
   
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
                                "profileImageUrl": profileImageUrl

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


    


