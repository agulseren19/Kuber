//
//  myRidesDataSource.swift
//  Kuber
//
//  Created by Begum Sen on 24.11.2022.
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

class MyRidesDataSource {
    
    private var myRidesArray: [Ride] = []
    
    var delegate: MyRidesDataDelegate?
    
    init() {
    }
    
    func getListOfMyRides(){
        myRidesArray.removeAll()
        var mutex = 0
        print("myride count: \(User.sharedInstance.getRideArrayCount())")
        if (User.sharedInstance.getRideArrayCount() == 0){
            DispatchQueue.main.async {
                self.delegate?.noDataInMyRides()
            }
        }
        
        for i in 0..<User.sharedInstance.getRideArrayCount(){
            var rideId = User.sharedInstance.getRideArray()[i]
            print(rideId)
            let db = Firestore.firestore()
            let docRef2 = db.collection("rides").document(rideId)
            docRef2.getDocument { (document, error) in
                if let document = document, document.exists {
                    var newRide = Ride (
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
                    
                    self.myRidesArray.append(newRide)
                    print("A")
                    mutex = mutex + 1
                    if (mutex == User.sharedInstance.getRideArrayCount()){

                        self.myRidesArray = self.myRidesArray.filter{(ride) -> Bool in
                            let date1 = ride.date // for day, month, year, we look at ride.date
                            let date2 = ride.time // for hour, minute, second, we look at ride.time
                            
                            // Therefore, we need to extract the components from the two dates
                            let date1Components = Calendar.current.dateComponents([.day, .month, .year], from: date1)
                            let date2Components = Calendar.current.dateComponents([.hour, .minute, .second], from: date2)
                            
                            // Create the date value that the user has selected for the ride
                            // by combining the components from the two dates
                            if let realDateOfRide = Calendar.current.date(from: DateComponents(year: date1Components.year, month: date1Components.month, day: date1Components.day, hour: date2Components.hour, minute: date2Components.minute, second: date2Components.second)){
                                
                                return realDateOfRide >= Date()
                            }else {
                                // not a valid date
                                return false
                            }               

                        }
                        self.myRidesArray = self.myRidesArray.sorted(by: { $0.date < $1.date })
                        DispatchQueue.main.async {
                            if(self.myRidesArray.count == 0){
                                self.delegate?.noDataInMyRides()
                            } else {
                                self.delegate?.myRidesListLoaded()
                            }
                        }
                        print("C")
                    }
                    
                } else {
                    print("Document does not exist in my Ride")
                }
                
            }
            
        }
        print("B")
    }
    
    func getListOfMyPreviousRides (){
        myRidesArray.removeAll()
        var mutex = 0
        if (User.sharedInstance.getRideArrayCount() == 0){
            DispatchQueue.main.async {
                self.delegate?.noDataInMyRides()
            }
        }
        for i in 0..<User.sharedInstance.getRideArrayCount(){
            var rideId = User.sharedInstance.getRideArray()[i]
            print(rideId)
            let db = Firestore.firestore()
            let docRef2 = db.collection("rides").document(rideId)
            docRef2.getDocument { (document, error) in
                if let document = document, document.exists {
                    var newRide = Ride (
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
                    self.myRidesArray.append(newRide)
                    print("AA")
                    mutex = mutex + 1
                    if (mutex == User.sharedInstance.getRideArrayCount()){
                        self.myRidesArray = self.myRidesArray.filter{ $0.date < Date() }
                        self.myRidesArray = self.myRidesArray.sorted(by: { $0.date < $1.date })
                        if (self.myRidesArray.count == 0){
                            DispatchQueue.main.async {
                                self.delegate?.noDataInMyRides()
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.delegate?.myRidesListLoaded()
                            }
                        }
                        print("CC")
                    }
                    
                } else {
                    print("Document does not exist in my Ride")
                }
                
            }
            
        }
        print("BB")
    }

    func getNumberOfmyRides() -> Int {
        return myRidesArray.count
    }
    
    func getMyRide(for index:Int) -> Ride? {
        guard index < myRidesArray.count else {
            return nil
        }
        return myRidesArray[index]
    }
}
