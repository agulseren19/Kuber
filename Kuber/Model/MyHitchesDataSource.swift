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
    private var hitchCount: Int = 0
    var rideInfoArray: [Ride] = []
    var delegate: MyHitchesDataDelegate?
    
    init() {
    }
    
    func getListOfHitches() {
        myHitchesArray = []
        rideInfoArray = []
        var mutex = 0
        for i in 0..<User.sharedInstance.getMyHitchesArrayCount(){
            var hitchId = User.sharedInstance.getMyHitchesArray()[i]
            print(hitchId)
            let db = Firestore.firestore()
            let docRef2 = db.collection("hitches").document(hitchId)
            docRef2.getDocument { (document, error) in
                if let document = document, document.exists {
                    var newHitch = Hitch (
                        date: (document.get("date") as! Timestamp).dateValue(),
                        hitchhikerMail: document.get("hitchhikerMail") as! String,
                        rideId: document.get("rideId") as! String,
                        status: document.get("status") as! Int,
                        ride: Ride(rideId: "", fromLocation: "", toLocation: "", date: Date(), seatAvailable: 0, fee: 0, mail: "")
                    )
                    self.myHitchesArray.append(newHitch)
                    print("A")
                    mutex = mutex + 1
                    if (mutex == User.sharedInstance.getMyHitchesArrayCount()){
                        self.getRideInfo()
                        print("C")
                    }
                    
                } else {
                    print("Document does not exist in my Ride")
                }
                
            }
            
        }
       
    }
    
    func getRideInfo() {
        let db = Firestore.firestore()
        var mutex = 0
        if (myHitchesArray.count == 0){
            DispatchQueue.main.async {
                self.delegate?.hitchListLoaded()
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
                            toLocation: document.get("to") as! String,
                            date: (document.get("date") as! Timestamp).dateValue(),
                            seatAvailable: document.get("numberOfSeats") as! Int,
                            fee: document.get("fee") as! Int,
                            mail: document.get("mail") as! String
                            
                        )
                        self.myHitchesArray[i].ride = ride
                        mutex = mutex + 1
                        if (mutex == self.myHitchesArray.count){
                            DispatchQueue.main.async {
                                self.delegate?.hitchListLoaded()
                            }
                            print("C")
                        }
                    }
                }
            }
        }
    }
    func getNumberOfHitches() -> Int {
        return self.myHitchesArray.count
    }
    
    func getHitch(for index: Int) -> Hitch? {
        guard index < myHitchesArray.count else {
            return nil
        }
        return myHitchesArray[index]
    }
    
}


