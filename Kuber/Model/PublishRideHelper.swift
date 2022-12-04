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
    var mutex: Int = 0
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
            "fee": Int(fee),
            "numberOfSeats": numberOfSeats,
            "mail" :User.sharedInstance.getEmail(),
            

        ]) { err in

            if let err = err {

                print("Error writing publish data: \(err)")

            } else {
                
                print("Publish data successfully written!")
                self.mutex = self.mutex + 1
                if self.mutex == 2 {
                    print("hereeee1")
                    self.delegate?.publishedToDatabase()
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
                   print("hereeee2")
                   self.delegate?.publishedToDatabase()
               }
           } else {
               print("Document does not exist")
           }
       }
        

    }
    
    
    }
    

