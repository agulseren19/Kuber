//
//  RidesDataSource.swift
//  Kuber
//
//  Created by Arda Aliz on 1.12.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class RidesDataSource{
    
    private var ridesArray: [Ride] = []
    private var rideCount: Int = 0
    
    var delegate: RidesDataDelegate?
    
    init() {
    }
    
    func getListOfRidesWithShowAll() {
        var mutex = 0
        let db = Firestore.firestore()

        db.collection("rides").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents for Rides Screen: \(err)")
            } else {
                self.rideCount = querySnapshot!.count
                print("querySnapshot!.count:")
                print(querySnapshot!.count)
                
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let newRide = Ride (
                        rideId: document.documentID,
                        fromLocation: document.get("from") as! String,
                        toLocation: document.get("to") as! String,
                        date: (document.get("date") as! Timestamp).dateValue(),
                        seatAvailable: document.get("numberOfSeats") as! Int,
                        fee: document.get("fee") as! Int,
                        mail: document.get("mail") as! String
                    )
                    
                    self.ridesArray.append(newRide)
                    print("X")
                    
                    mutex = mutex + 1
                    if (mutex == self.rideCount){
                        DispatchQueue.main.async {
                            self.delegate?.ridesListLoaded()
                            print("Y")
                        }
                    }
                }
                print("Z")
            }
        }
    }
    
    func getNumberOfRides() -> Int {
        return ridesArray.count
    }
    
    func getRide(for index: Int) -> Ride? {
        guard index < ridesArray.count else {
            return nil
        }
        return ridesArray[index]
    }
    
}
