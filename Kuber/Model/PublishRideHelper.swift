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
import FirebaseCore
import FirebaseCore
import GoogleSignIn
import FirebaseCore
import FirebaseFirestore

class PublishRideHelper {
    var delegate: PublishRideDelegate?
    init() {
    }
    
    func saveRide(from:String,to:String, date:Date, time: Date, fee :String, numberOfSeats: Int){
        let db = Firestore.firestore()
        let id = db.collection("rides").document().documentID;
        db.collection("rides").document(id).setData([

            //"id" = user ride publish ettiğinde random id ata
            "from": from,
            "to": to,
            "date": date,
            "time": time,
            "fee": fee,
            "numberOfSeats": numberOfSeats,
            "mail" :User.sharedInstance.getEmail(),
            

        ]) { err in

            if let err = err {

                print("Error writing publish data: \(err)")

            } else {

                print("Publish data successfully written!")

            }
        }
        
        let docRef = db.collection("users").document(User.sharedInstance.getEmail())
       docRef.getDocument { (document, error) in
           if let document = document, document.exists {
               docRef.updateData([
                   "publishedRides": FieldValue.arrayUnion([id])
               ])
           } else {
               print("Document does not exist")
           }
       }
        User.sharedInstance.appendToRideArray(id: id)

    }
    }
    

