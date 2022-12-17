//
//  ProfilePictureHelper.swift
//  Kuber
//
//  Created by Begum Sen on 17.12.2022.
//

import Foundation

class ProfilePictureHelper {
    
    var imageData: Data = Data()
    var delegate: ProfilePictureDelegate?
    
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

