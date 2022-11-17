//
//  SecondSignUpHelper.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 17.11.2022.
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
class SecondSignUpHelper{
    var delegate: SecondSignUpDelegate?
    
    init() {
    }
    func signUp(fullName: String, phoneNumber: String, major:String, segmentIndex:Int, smokingFlag: Bool, chattinessFlag: Bool, userEmail: String) {
        var classLevel: String = ""
        if segmentIndex==0 {
            classLevel = "ELC"
        }
        if segmentIndex==1 {
            classLevel = "Freshman"
        }
        if segmentIndex==2 {
            classLevel = "Sophomore"
        }
        if segmentIndex==3 {
            classLevel = "Junior"
        }
        if segmentIndex==4 {
            classLevel = "Senior"
        }
        let db = Firestore.firestore()
        db.collection("users").document(userEmail).updateData([
                    "smokingFlag": smokingFlag,
                    "fullName": fullName,
                    "phoneNumber": phoneNumber,
                    "major": major,
                    "classLevel": classLevel,
                    "chattinessFlag": chattinessFlag,

                ]) { err in

                    if let err = err {

                        print("Error writing document: \(err)")

                    } else {

                        print("Document successfully written!")
                        self.delegate?.makeFieldsEmpty()
                    }

                }
        

    }
    
}
