//
//  RideRequestDataSource.swift
//  Kuber
//
//  Created by Begum Sen on 13.12.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class RideRequestDataSource {
    
    private var hitchArray: [Hitch] = []
    private var rideRequestArray: [RideRequest] = []
    var delegate: RideRequestDataDelegate?
    var requestCount = 0
    var rideCell: Ride?
    
    init() {
    }
    
    func getListOfRideRequest(ride: Ride) {
        rideRequestArray.removeAll()
        hitchArray.removeAll()
        let db = Firestore.firestore()
        self.rideCell = ride
        let docRef = db.collection("rides").document(ride.rideId)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let rideRequests = document.get("hitchRequests") as! [String]
                self.getHitchInfo(hitches: rideRequests)
            } else {
                print("Document does not exist in my Ride")
            }
        }
    }
    
    func getHitchInfo(hitches: [String]){
        var mutex = 0
        
        for hitch in hitches {
            var hitchId = hitch
            print(hitchId)
            let db = Firestore.firestore()
            let docRef2 = db.collection("hitches").document(hitchId)
            docRef2.getDocument { (document, error) in
                if let document = document, document.exists {
                    var newHitch = Hitch (
                        hitchId: hitchId,
                        date: (document.get("date") as! Timestamp).dateValue(),
                        hitchhikerMail: document.get("hitchhikerMail") as! String,
                        rideId: document.get("rideId") as! String,
                        status: document.get("status") as! Int,
                        ride: self.rideCell!
                    )
                    self.hitchArray.append(newHitch)
                    mutex = mutex + 1
                    if (mutex == hitches.count){
                        self.getHitcherInfo()
                    }
                    
                } else {
                    print("Document does not exist in my Ride")
                }
            }
        }
    }
    
    func getHitcherInfo() {
        var mutex = 0
        for hitch in self.hitchArray {
            var hitchhikerMail = hitch.hitchhikerMail
            let db = Firestore.firestore()
            let docRef2 = db.collection("users").document(hitchhikerMail)
            docRef2.getDocument { (document, error) in
                if let document = document, document.exists {
                    var newRideRequest = RideRequest (
                        hitchhikeId: hitch.hitchId,
                        date: hitch.date,
                        hitchhikerMail: hitch.hitchhikerMail,
                        rideId: hitch.rideId,
                        status: hitch.status,
                        ride: hitch.ride,
                        hitchhikerName: document.get("fullName") as! String,
                        hitchhikerMajor: document.get("major") as! String,
                        hitchhikerGradeLevel: document.get("classLevel") as! String,
                        hitchhikerPhoneNumber: document.get("phoneNumber") as! String
                    )
                    self.rideRequestArray.append(newRideRequest)
                    mutex = mutex + 1
                    if (mutex == self.hitchArray.count){
                        self.delegate?.rideRequestListLoaded()
                    }
                    
                } else {
                    print("Document does not exist in my Ride")
                }
            }
        }
    }
    
    func getNumberOfRideRequest() -> Int {
        return rideRequestArray.count
    }
    
    func getRideRequest(for index:Int) -> RideRequest? {
        guard index < rideRequestArray.count else {
            return nil
        }
        return rideRequestArray[index]
    }
}
