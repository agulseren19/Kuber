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
                            var calendar = Calendar.current
                            var rideDateYear = calendar.component(.year, from: ride.date)
                            var rideDateMonth = calendar.component(.month, from: ride.date)
                            var rideDateDay = calendar.component(.day, from: ride.date)
                            var rideTimeHour = calendar.component(.hour, from: ride.time)
                            var rideTimeMinute = calendar.component(.minute, from: ride.time)
                            
                            print("Ride date info")
                            print(rideDateDay)
                            print(rideTimeHour)
                            print(rideTimeMinute)
                            
                            var dateComponents = DateComponents()
                            dateComponents.year = rideDateYear
                            dateComponents.month = rideDateMonth
                            dateComponents.day = rideDateDay
                            dateComponents.timeZone = TimeZone(identifier: "UTC+03:00")
                            dateComponents.hour = rideTimeHour
                            dateComponents.minute = rideTimeMinute
                            
                            
                            
                            
                            if let rideDate = dateComponents.date {
                                print("Date components.date:")
                                print(dateComponents.isValidDate)
                                print(rideDate)
                                return rideDate >= Date()
                            } else{
                                print("there is no date value from the date components")
                                return false
                            }
                            
                            
                            

                        }
                        self.myRidesArray = self.myRidesArray.sorted(by: { $0.date < $1.date })
                        self.delegate?.myRidesListLoaded()
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
                        self.delegate?.myRidesListLoaded()
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
