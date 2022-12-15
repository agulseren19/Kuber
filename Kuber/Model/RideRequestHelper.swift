//
//  RideRequestHelper.swift
//  Kuber
//
//  Created by Begum Sen on 16.12.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class RideRequestHelper {
    
    var delegate: RideRequestDataDelegate?
    
    func acceptTheRideRequest (ride: RideRequest){
        
        let db = Firestore.firestore()
        let id = db.collection("hitches").document().documentID;
        db.collection("hitches").document(ride.hitchhikeId).updateData(["status" : 1 ]){ err in
            
            if let err = err {
                
                print("Error writing publish data: \(err)")
                
            } else {
                //self.delegate?.rideRequestListLoaded()
            }
        }
    }
    
    func declineTheRideRequest (ride: RideRequest){
        
        let db = Firestore.firestore()
        let id = db.collection("hitches").document().documentID;
        db.collection("hitches").document(ride.hitchhikeId).updateData(["status" : 0 ])
        { err in
            
            if let err = err {
                
                print("Error writing publish data: \(err)")
                
            } else {
                //self.delegate?.rideRequestListLoaded()
            }
        }
    }
}
