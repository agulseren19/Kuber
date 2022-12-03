//
//  MyHitchesDataSource.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 4.12.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class MyHitchesDataSource{
    
    private var myHitchesArray: [Hitch] = []
    private var hitchCount: Int = 0
    
    var delegate: MyHitchesDataDelegate?
    
    init() {
    }
    
    func getListOfHitches() {
        var mutex = 0
        let db = Firestore.firestore()

        db.collection("hitches").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents for Hitchs Screen: \(err)")
            } else {
                self.hitchCount = querySnapshot!.count
                print("querySnapshot!.count:")
                print(querySnapshot!.count)
                
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let newHitch = Hitch (
                        fromLocation: document.get("from") as! String,
                        toLocation: document.get("to") as! String,
                        date: (document.get("date") as! Timestamp).dateValue(),
                        fee: document.get("fee") as! String,
                        mail: document.get("mail") as! String,
                        hitchhikeStatus: document.get("status") as! Int
                    )
                    
                    self.myHitchesArray.append(newHitch)
                    print("X")
                    
                    mutex = mutex + 1
                    if (mutex == self.hitchCount){
                        DispatchQueue.main.async {
                            self.delegate?.hitchListLoaded()
                            print("Y")
                        }
                    }
                }
                print("Z")
            }
        }
    }
    
    func getNumberOfHitches() -> Int {
        return myHitchesArray.count
    }
    
    func getHitch(for index: Int) -> Hitch? {
        guard index < myHitchesArray.count else {
            return nil
        }
        return myHitchesArray[index]
    }
    
}


