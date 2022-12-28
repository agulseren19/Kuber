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
    var noSmokingPreference : Bool = false
    var chattinesFlag : Bool = false
    var ridesArray = [String]()
    var myHitchesArray = [String]()
    var myHitchestoRideIdArray: [String] = []
    var profilePictureUrl: String = ""
    var deviceTokenString: String = ""

   private override init() { }

    func setEmail(email : String) {
       self.email = email
   }
    
    func setProfilePictureUrl(profilePictureUrl: String) {
       self.profilePictureUrl = profilePictureUrl
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
    func setDeviceTokenString(deviceTokenString : String) {
        self.deviceTokenString = deviceTokenString
    }
     
     func getDeviceTokenString() -> String {
         return self.deviceTokenString
     }
    func setNoSmokingPreference(noSmokingPreference : Bool) {
        self.noSmokingPreference = noSmokingPreference
    }
     
     func getNoSmokingPreference() -> Bool {
         return self.noSmokingPreference
     }
    func setSilentRidePreference(silentRidePreference : Bool) {
        self.chattinesFlag = silentRidePreference
    }
     
     func getSilentRidePreference() -> Bool {
         return self.chattinesFlag
     }
    
    func setRidesArray(ridesArray : [String]) {
        self.ridesArray = ridesArray
    }
    
    func setMyHitchesToRideIdArray (rideIds : [String]) {
        self.myHitchestoRideIdArray = rideIds
    }
    
    func getMyHitchesToRideIdArray() -> [String] {
        return self.myHitchestoRideIdArray
    }
    
    func appendToRideArray(id : String) {
        self.ridesArray.append(id)
   }
    
    func getRideArray() -> [String] {
        return self.ridesArray
    }
    
    func getRideArrayCount () -> Int {
        self.ridesArray.count
    }
    
    func setMyHitchesArray(myHitchesArray : [String]) {
        self.myHitchesArray = myHitchesArray
    }
    
    func appendToMyHitchesArray(id : String) {
        self.myHitchesArray.append(id)
   }
    
    func getMyHitchesArray() -> [String] {
        return self.myHitchesArray
    }
    
    func getMyHitchesArrayCount () -> Int {
        self.myHitchesArray.count
    }
}
