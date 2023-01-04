//
//  PublishRideHelper.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 28.11.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class PublishRideHelper {
    var delegate: PublishRideDelegate?
    var mutex: Int = 0
    init() {
    }
    
    func saveRide(from:String, fromNeighbourhood:String,to:String,toNeighbourhood:String, date:Date, time: Date, fee :String, numberOfSeats: Int){
        let db = Firestore.firestore()
        let id = db.collection("rides").document().documentID;
        db.collection("rides").document(id).setData([

            //"id" = user ride publish ettiğinde random id ata
            "from": from,
            "fromNeighbourhood": fromNeighbourhood,
            "to": to,
            "toNeighbourhood": toNeighbourhood,
            "date": date,
            "time": time,
            "fee": Int(fee),
            "numberOfSeats": numberOfSeats,
            "mail" :User.sharedInstance.getEmail(),
            "hitchRequests" :[]
            

        ]) { err in

            if let err = err {


            } else {
                
                self.mutex = self.mutex + 1
                if self.mutex == 2 {
                    DispatchQueue.main.async {
                        self.delegate?.publishedToDatabase()
                    }
                }

            }
        }
        
        let docRef = db.collection("users").document(User.sharedInstance.getEmail())
       docRef.getDocument { (document, error) in
           if let document = document, document.exists {
               docRef.updateData([
                   "publishedRides": FieldValue.arrayUnion([id])
               ])
               User.sharedInstance.appendToRideArray(id: id)
               self.mutex = self.mutex + 1
               if self.mutex == 2 {
                   DispatchQueue.main.async {
                       self.delegate?.publishedToDatabase()
                   }
               }
           } else {
           }
       }
        

    }
    
    
    }
    

