//
//  ProfilePictureHelper.swift
//  Kuber
//
//  Created by Begum Sen on 17.12.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class ProfilePictureHelper {
    
    var imageData: Data = Data()
    var delegate: ProfilePictureDelegate?
    private let storage = Storage.storage().reference()
    
    func setImageUrl(email: String, imageData: Data){
        
        storage.child("images/_\(email)_.png").putData(imageData, metadata: nil, completion: { _, error in
            guard error == nil else {
                print(error)
                return
            }
            self.storage.child("images/_\(email)_.png").downloadURL(completion: { url, error in
                guard let url = url, error == nil else{
                    return
                }
                let urlString = url.absoluteString
                User.sharedInstance.profilePictureUrl = urlString
                let db = Firestore.firestore()
                let id = db.collection("users").document().documentID;
                db.collection("users").document(email).updateData(["profileImageUrl" : urlString ]){ err in
                    
                    if let err = err {
                        
                        print("Error writing publish data: \(err)")
                        
                    } else {
                        //self.delegate?.rideRequestListLoaded()
                    }
                }
            })
        })
    }
    
    
    
}

