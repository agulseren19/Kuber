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
import UIKit

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
    
    func callNumber(phoneNumber: String) {
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application: UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func getOthersideTokenValueFromFirestore(rideRequest: RideRequest, completion: @escaping (String) -> Void) {
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(rideRequest.hitchhikerMail)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                let token = document.get("deviceToken") as! String // The device token of the recipient's device
                
                completion(token)
            }
        }
    }
    
    func sendNotificationWithFirebase(rideRequest: RideRequest, isRequestAccepted: Bool){
        getOthersideTokenValueFromFirestore(rideRequest: rideRequest) { token in
            let serverKey = "AAAA4UHXh0E:APA91bFI7jYXFrSSK4xBOlDXOUSfM_u_T-AMMOpVF1ReXETPWT6bFJvFquQidpxxLct6iGYuqVSSqEgn2ECt6MSlxpFOyBmGcJTnQLnpPdJabqxtHJq-nTWizoBBo66YLp_Mw312LE1V"
            let fcmUrl = "https://fcm.googleapis.com/fcm/send"
            
            let to = token
            let senderName = User.sharedInstance.getFullName()
            
            let notification = isRequestAccepted
                ? ["title": "\(senderName) accepted your hitchhike!", "body": "Wait for a call from the rider!"]
                : ["title": "\(senderName) declined your hitchhike", "body": "Search for other rides that fit you!"]
            
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
