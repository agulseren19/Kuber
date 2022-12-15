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
    
    func getListOfMyRides (){
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
                        seatAvailable: document.get("numberOfSeats") as! Int,
                        fee: document.get("fee") as! Int,
                        mail: document.get("mail") as! String
                    )
                    self.myRidesArray.append(newRide)
                    print("A")
                    mutex = mutex + 1
                    if (mutex == User.sharedInstance.getRideArrayCount()){
                        
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
