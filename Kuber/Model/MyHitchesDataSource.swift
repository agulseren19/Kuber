//
//  MyHitchesDataSource.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 4.12.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class MyHitchesDataSource{
    
    private var myHitchesArray: [Hitch] = []
    private var myFinalHitchesArray: [MyHitch] = []
    private var hitchCount: Int = 0
    var rideInfoArray: [Ride] = []
    var rideIdsUserHitched: [String] = []
    var delegate: MyHitchesDataDelegate?
    
    init() {
    }
    
    func getListOfHitches(areCurrentHitches: Bool) {
        self.myHitchesArray.removeAll()
        self.myFinalHitchesArray.removeAll()
        self.rideInfoArray.removeAll()
        var mutex = 0
        
        if (User.sharedInstance.getMyHitchesArrayCount() == 0){
            DispatchQueue.main.async {
                self.delegate?.noDataInMyHitches()
            }
        }
        
        for i in 0..<User.sharedInstance.getMyHitchesArrayCount(){
            var hitchId = User.sharedInstance.getMyHitchesArray()[i]
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
                        ride: Ride(rideId: "", fromLocation: "",  fromNeighbourhoodLocation: "",toLocation: "",toNeighbourhoodLocation: "", date: Date(),time: Date(), seatAvailable: 0, fee: 0, mail: "", hitched: false)
                    )
                    self.myHitchesArray.append(newHitch)
                    print("A")
                    mutex = mutex + 1
                    if (mutex == User.sharedInstance.getMyHitchesArrayCount()){
                        
                        self.getRideInfo(areCurrentHitches: areCurrentHitches)
                        print("C")
                    }
                    
                } else {
                    print("Document does not exist in my Ride")
                }
                
            }
            
        }
       
    }
    
    func getRideInfo(areCurrentHitches: Bool) {
        let db = Firestore.firestore()
        var mutex = 0
        if (myHitchesArray.count == 0){
            DispatchQueue.main.async {
                self.delegate?.noDataInMyHitches()
            }
        } else{
            for i in 0..<myHitchesArray.count {
                var hitch = myHitchesArray[i]
                var rideId = hitch.rideId
                let docRef2 = db.collection("rides").document(rideId)
                docRef2.getDocument { (document, error) in
                    if let document = document, document.exists {
                        var ride = Ride (
                            rideId: rideId,
                            fromLocation: document.get("from") as! String,
                            fromNeighbourhoodLocation: document.get("fromNeighbourhood") as! String,
                            toLocation: document.get("to") as! String,
                            toNeighbourhoodLocation: document.get("toNeighbourhood") as! String,
                            date: (document.get("date") as! Timestamp).dateValue(),
                            time: (document.get("time") as! Timestamp).dateValue(),
                            seatAvailable: document.get("numberOfSeats") as! Int,
                            fee: document.get("fee") as! Int,
                            mail: document.get("mail") as! String,
                            hitched: false
                        )
                        self.myHitchesArray[i].ride = ride
                        mutex = mutex + 1
                        if (mutex == self.myHitchesArray.count){
                            self.getRiderInfo(areCurrentHitches: areCurrentHitches)
                            print("C")
                        }
                    }
                }
            }
        }
    }
    
    func getRiderInfo(areCurrentHitches: Bool){
        let db = Firestore.firestore()
        var mutex = 0
        for i in 0..<myHitchesArray.count {
            var hitch = myHitchesArray[i]
            var riderMail = hitch.ride.mail
            let docRef2 = db.collection("users").document(riderMail)
            docRef2.getDocument { (document, error) in
                if let document = document, document.exists {
                    var newMyHitch = MyHitch(
                        hitch: hitch,
                        riderFullName: document.get("fullName") as! String,
                        riderMajor: document.get("major") as! String
                    )
                    self.myFinalHitchesArray.append(newMyHitch)
                    print("A")
                    mutex = mutex + 1
                    if (mutex == self.myHitchesArray.count){
                        DispatchQueue.main.async {
                            self.isAlreadyHitched()
                            
                            // Displaying the current (not expired/old) hitchhikes of the user in the table view
                            // The filtering is dependent on the ride's original date that the hitchhiker has requested
                            self.myFinalHitchesArray = self.myFinalHitchesArray.filter{(myHitch) -> Bool in
                                let date1 = myHitch.hitch.ride.date // for day, month, year, we look at ride.date
                                let date2 = myHitch.hitch.ride.time // for hour, minute, second, we look at ride.time
                                
                                // Therefore, we need to extract the components from the two dates
                                let date1Components = Calendar.current.dateComponents([.day, .month, .year], from: date1)
                                let date2Components = Calendar.current.dateComponents([.hour, .minute, .second], from: date2)
                                
                                // Create the date value that the user has selected for the ride
                                // by combining the components from the two dates
                                if let realDateOfRide = Calendar.current.date(from: DateComponents(year: date1Components.year, month: date1Components.month, day: date1Components.day, hour: date2Components.hour, minute: date2Components.minute, second: date2Components.second)){
                                    
                                    if areCurrentHitches {
                                        // My Hitches Screen would have areCurrentHitches: true
                                        // The current hitches would be displayed
                                        return realDateOfRide >= Date()
                                    } else {
                                        // History of Hitchhikes Screen would have areCurrentHitches: false
                                        // The old hitches would be displayed
                                        return realDateOfRide < Date()
                                    }
                                    
                                }else {
                                    print("realDateOfRide is not valid")
                                    return false
                                }
                                
                            }
                            
                            self.myFinalHitchesArray = self.myFinalHitchesArray.sorted(by: { $0.hitch.date < $1.hitch.date })
                            DispatchQueue.main.async {
                                if (self.myFinalHitchesArray.count == 0){
                                    self.delegate?.noDataInMyHitches()
                                }else{
                                    self.delegate?.hitchListLoaded()
                                }
                            }
                        }
                        print("C")
                    }
                    
                } else {
                    print("Document does not exist in my Ride")
                }
                
            }
            
        }
            
    }
    
    func isAlreadyHitched (){
        var mutex = 0
        rideIdsUserHitched.removeAll()
        for hitches in User.sharedInstance.getMyHitchesArray(){
            let db = Firestore.firestore()
            let docRef2 = db.collection("hitches").document(hitches)
            docRef2.getDocument { (document, error) in
                if let document = document, document.exists {
                    let rideId = document.get("rideId") as! String
                    self.rideIdsUserHitched.append(rideId)
                    mutex = mutex + 1
                    if(mutex == User.sharedInstance.getMyHitchesArray().count){
                        User.sharedInstance.setMyHitchesToRideIdArray(rideIds: self.rideIdsUserHitched)
                    }
                }
            }
        }
        
    }
    
    func getNumberOfHitches() -> Int {
        return self.myFinalHitchesArray.count
    }
    
    func getHitch(for index: Int) -> MyHitch? {
        guard index < myFinalHitchesArray.count else {
            return nil
        }
        return myFinalHitchesArray[index]
    }
    
}


