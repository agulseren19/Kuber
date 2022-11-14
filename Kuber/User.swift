//
//  User.swift
//  Kuber
//
//  Created by UTKU on 14.11.2022.
//

import Foundation

final class User: NSObject {
   static let sharedInstance = User()
    
    var email : String = ""
    var password : String = ""
    var fullName : String = ""
    var phoneNumber : String = ""
    var major : String = ""
    var classLevel : String = ""
    var smokingPreference : Bool = false
    var silencePreference : Bool = false
    

   private override init() { }

    func setEmail(email : String) {
       self.email = email
   }
    
    func getEmail() -> String {
        return self.email
    }
    
    func setPassword(password : String) {
        self.password = password
    }
     
     func getPassword() -> String {
         return self.password
     }
    
    func setFullName(fullName : String) {
        self.fullName = fullName
    }
     
     func getFullName() -> String {
         return self.fullName
     }
    func setPhoneNumber(phoneNumber : String) {
        self.phoneNumber = phoneNumber
    }
     
     func getPhoneNumber() -> String {
         return self.phoneNumber
     }
    func setMajor(major : String) {
        self.major = major
    }
     
     func getMajor() -> String {
         return self.major
     }
    func setClassLevel(classLevel : String) {
        self.classLevel = classLevel
    }
     
     func getClassLevel() -> String {
         return self.classLevel
     }
    func setSmokingPreferecne(smokingPreference : Bool) {
        self.smokingPreference = smokingPreference
    }
     
     func getSmokingPreference() -> Bool {
         return self.smokingPreference
     }
    func setSilencePreference(silencePreference : Bool) {
        self.silencePreference = silencePreference
    }
     
     func getSilencePreference() -> Bool {
         return self.silencePreference
     }
}
