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
                print("failed")
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
                        print("succesfull")
                        //self.delegate?.rideRequestListLoaded()
                    }
                }
                print("downloaded: \(urlString)")
            })
        })
    }
    
    func getImageDataFromFireStorage(urlString: String){
        print("profile picture: ")
        print(urlString)
        guard let url = URL(string: urlString) else {
            return
        }
        print("passed url")
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            if let data = data {
                print(error)
                if error == nil {
                    self.imageData = data
                    print("hereeee image loaded")
                    DispatchQueue.main.async {
                        self.delegate?.profileImageLoaded()
                    }
                }
            }else{
                print("error url")
                return
            }
        })
        task.resume()
    }
    
}

