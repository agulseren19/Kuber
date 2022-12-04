//
//  RidesAfterSearchHelper.swift
//  Kuber
//
//  Created by Begum Sen on 4.12.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class RidesAfterSearchHelper {
    
    var delegate: RidesAfterSearchDelegate?
    
    func saveHitchToDatabase(ride: Ride){
        print("RidesAfterSearchHelper is reached")
        print(ride.rideId)
        //delegate?.hitchIsSavedToFirebase()
    }
    
}
