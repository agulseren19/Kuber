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
    
    init() {
    }
    
    func getListOfRidesWithShowAll(){
        var mutex = 0
        
        let db = Firestore.firestore()
        let collection = db.collection("rides")
        let rideCount = collection.count
        
        
        db.collection("rides").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                }
            }
        }
        
        print(rideCount)
        
        
        
        
    }
}

