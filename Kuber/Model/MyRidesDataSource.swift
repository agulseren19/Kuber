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
        
        for i in 0..<User.sharedInstance.getRideArrayCount(){
            var rideId = User.sharedInstance.getRideArray()[i]
           
            let db = Firestore.firestore()
            let docRef2 = db.collection("rides").document(rideId)
            docRef2.getDocument { (document, error) in
                if let document = document, document.exists {
                    var newRide = Ride (
                        fromLocation: document.get("from") as! String,
                        toLocation: document.get("to") as! String,
                        date: (document.get("date") as! Timestamp).dateValue(),
                        seatAvailable: document.get("numberOfSeats") as! Int,
                        fee: document.get("fee") as! String
                    )
                    self.myRidesArray.append(newRide)
                    print("A")
                    if (i == User.sharedInstance.getRideArrayCount()-1){
                        self.delegate?.myRidesListLoaded()
                        print("C")
                    }
                    
                } else {
                    print("Document does not exist")
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
