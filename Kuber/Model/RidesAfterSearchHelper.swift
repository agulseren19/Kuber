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
    var mutex = 0
    
    func saveHitchToDatabase(ride: Ride){
        let db = Firestore.firestore()
        var hitchedRideIds = User.sharedInstance.getMyHitchesToRideIdArray()
        hitchedRideIds.append(ride.rideId)
        User.sharedInstance.setMyHitchesToRideIdArray(rideIds: hitchedRideIds)
        let id = db.collection("hitches").document().documentID;
        db.collection("hitches").document(id).setData([
            
            //"id" = user ride publish ettiğinde random id ata
            "date": Date(),
            "hitchhikerMail" :User.sharedInstance.getEmail(),
            "rideId": ride.rideId,
            "status": 2
            
        ]) { err in
            
            if let err = err {
                
                print("Error writing publish data: \(err)")
                
            } else {
                
                self.mutex = self.mutex + 1
                if self.mutex == 3 {
                    self.delegate?.hitchIsSavedToFirebase()
                }
                
            }
            
        }
        
        let docRef = db.collection("users").document(User.sharedInstance.getEmail())
       docRef.getDocument { (document, error) in
           if let document = document, document.exists {
               docRef.updateData([
                   "myHitches": FieldValue.arrayUnion([id])
               ])
               User.sharedInstance.appendToMyHitchesArray(id: id)
               self.mutex = self.mutex + 1
               if self.mutex == 3 {
                   self.delegate?.hitchIsSavedToFirebase()
               }
           } else {
           }
       }
        
        let docRef2 = db.collection("rides").document(ride.rideId)
        docRef2.getDocument { (document, error) in
           if let document = document, document.exists {
               docRef2.updateData([
                   "hitchRequests": FieldValue.arrayUnion([id])
               ])
               self.mutex = self.mutex + 1
               if self.mutex == 3 {
                   self.delegate?.hitchIsSavedToFirebase()
               }
           } else {
           }
       }
        
    }
    
    func getOthersideTokenValueFromFirestore(ride: Ride, completion: @escaping (String) -> Void) {
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(ride.mail)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                let token = document.get("deviceToken") as! String // The device token of the recipient's device
                
                completion(token)
            }
        }
        
    }
    
    func sendNotificationWithFirebase(ride: Ride){
        getOthersideTokenValueFromFirestore(ride: ride) { token in
            let serverKey = "AAAA4UHXh0E:APA91bFI7jYXFrSSK4xBOlDXOUSfM_u_T-AMMOpVF1ReXETPWT6bFJvFquQidpxxLct6iGYuqVSSqEgn2ECt6MSlxpFOyBmGcJTnQLnpPdJabqxtHJq-nTWizoBBo66YLp_Mw312LE1V"
            let fcmUrl = "https://fcm.googleapis.com/fcm/send"
            
            let to = token
            let senderName = User.sharedInstance.getFullName()
            
            let notification = ["title": "Hitchhike Request from \(senderName)!", "body": "Tap on your ride to see the request!"]
            let data = ["senderName": senderName]

            let headers = ["Content-Type": "application/json", "Authorization": "key=\(serverKey)"]
            let payload: [String: Any] = ["to": to, "notification": notification, "data": data]

            let request = NSMutableURLRequest(url: NSURL(string: fcmUrl)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = try? JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)

            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
              if (error != nil) {
                print(error!)
              } else {
                print(response!)
              }
            })

            dataTask.resume()

        }
        
    }
    
}
