//
//  SecondSignUpHelper.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 17.11.2022.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class SecondSignUpHelper{
    var delegate: SecondSignUpDelegate?
    
    var user = User.sharedInstance

    init() {
    }
    
    func signUp(fullName: String, phoneNumber: String, major:String, segmentIndex:Int, noSmokingFlag: Bool, silentRideFlag: Bool, userEmail: String) {
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
                    "smokingFlag": noSmokingFlag,
                    "fullName": fullName,
                    "phoneNumber": phoneNumber,
                    "major": major,
                    "classLevel": classLevel,
                    "chattinessFlag": silentRideFlag,
                    "publishedRides": [],
                    "myHitches": []


                ]) { err in

                    if let err = err {

                        print("Error writing document: \(err)")

                    } else {

                        self.delegate?.makeFieldsEmpty()
                    }

                }
        

    }
    
    func editUserData(fullName: String, phoneNumber: String, major:String, segmentIndex:Int, noSmokingFlag: Bool, silentRideFlag: Bool, userEmail: String) {
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
                    "smokingFlag": noSmokingFlag,
                    "fullName": fullName,
                    "phoneNumber": phoneNumber,
                    "major": major,
                    "classLevel": classLevel,
                    "chattinessFlag": silentRideFlag

                ]) { err in

                    if let err = err {

                        print("Error writing document: \(err)")

                    } else {

                        self.delegate?.makeFieldsEmpty()
                    }

                }
        

    }
    
    func setUserInfo(fullName: String, phoneNumber: String, major: String, segmentIndex: Int, noSmokingFlag: Bool, silentRideFlag: Bool){
        var classLevel: String = ""
        if segmentIndex==0 {
            classLevel = "ELC"
        } else if segmentIndex==1 {
            classLevel = "Freshman"
        } else if segmentIndex==2 {
            classLevel = "Sophomore"
        } else if segmentIndex==3 {
            classLevel = "Junior"
        } else if segmentIndex==4 {
            classLevel = "Senior"
        }
        
        user.setFullName(fullName: fullName)
        user.setPhoneNumber(phoneNumber: phoneNumber)
        user.setMajor(major: major)
        user.setClassLevel(classLevel: classLevel)
        user.setNoSmokingPreference(noSmokingPreference: noSmokingFlag)
        user.setSilentRidePreference(silentRidePreference: silentRideFlag)
        
    }
    
    func setFieldsOfInputsAsCurrentProfile() {
        let fullName = user.getFullName()
        let phoneNumber = user.getPhoneNumber()
        let noSmokingFlag = user.getNoSmokingPreference()
        let silentRideFlag = user.getSilentRidePreference()
        let major = user.getMajor()
        let classLevel = user.getClassLevel()
        
        var segmentIndex: Int = 0
        if classLevel == "ELC" {
            segmentIndex = 0
        } else if classLevel == "Freshman" {
            segmentIndex = 1
        } else if classLevel == "Sophomore" {
            segmentIndex = 2
        } else if classLevel == "Junior" {
            segmentIndex = 3
        } else if classLevel == "Senior" {
            segmentIndex = 4
        }
        
        let userEmail = user.getEmail()
        
        self.delegate?.setFieldsCurrentProfile(userEmail: userEmail ,fullName: fullName, phoneNumber: phoneNumber, major: major, segmentIndex: segmentIndex, noSmokingFlag: noSmokingFlag, silentRideFlag: silentRideFlag)
        
    }
    
    func setCurrentMajorAsChosen(actionTitle: String? = nil, menu: UIMenu) -> UIMenu {
        if let actionTitle = actionTitle {
            menu.children.forEach { action in
                guard let action = action as? UIAction else {
                    return
                }
                if action.title == actionTitle {
                    action.state = .on
                }
            }
        } else {
            let action = menu.children.first as? UIAction
            action?.state = .on
        }
        return menu
    }
    
}
