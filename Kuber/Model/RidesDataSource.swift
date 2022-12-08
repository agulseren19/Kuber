//
//  RidesDataSource.swift
//  Kuber
//
//  Created by Arda Aliz on 1.12.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class RidesDataSource{
    
    private var ridesArray: [Ride] = []
    private var rideCount: Int = 0
    
    var delegate: RidesDataDelegate?
    
    init() {
    }
    
    func getListOfRidesWithShowAll() {
        self.ridesArray.removeAll()
        var mutex = 0
        let db = Firestore.firestore()

        db.collection("rides").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents for Rides Screen: \(err)")
            } else {
                self.rideCount = querySnapshot!.count
                print("querySnapshot!.count:")
                print(querySnapshot!.count)
                
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let newRide = Ride (
                        rideId: document.documentID,
                        fromLocation: document.get("from") as! String,
                        toLocation: document.get("to") as! String,
                        date: (document.get("date") as! Timestamp).dateValue(),
                        seatAvailable: document.get("numberOfSeats") as! Int,
                        fee: document.get("fee") as! Int,
                        mail: document.get("mail") as! String
                    )
                    
                    self.ridesArray.append(newRide)
                    print("X")
                    
                    mutex = mutex + 1
                    if (mutex == self.rideCount){
                        DispatchQueue.main.async {
                            self.delegate?.ridesListLoaded()
                            print("Y")
                        }
                    }
                }
                print("Z")
            }
        }
    }
    
    func getListOfRidesWithoutShowAll() {
        var mutex = 0
        self.ridesArray.removeAll()
        let db = Firestore.firestore()

        db.collection("rides").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents for Rides Screen: \(err)")
            } else {
                self.rideCount = querySnapshot!.count
                print("querySnapshot!.count:")
                print(querySnapshot!.count)
                
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let newRide = Ride (
                        rideId: document.documentID,
                        fromLocation: document.get("from") as! String,
                        toLocation: document.get("to") as! String,
                        date: (document.get("date") as! Timestamp).dateValue(),
                        seatAvailable: document.get("numberOfSeats") as! Int,
                        fee: document.get("fee") as! Int,
                        mail: document.get("mail") as! String
                    )
                    
                    self.ridesArray.append(newRide)
                    print("X")
                    
                    mutex = mutex + 1
                    if (mutex == self.rideCount){
                        DispatchQueue.main.async {
                            self.delegate?.ridesListLoaded()
                            print("Y")
                            print("ride size")
                            print(self.getNumberOfRides())
                            self.sortTheRideArray()
                        }
                    }
                }
                print("Z")
            }
        }
        
        /*var fromTown = "Atasehir"//ilçe
        var fromNeighbourhood = "Barbaros" //Mahalle
        var toTown = "Sariyer"//ilçe
        var toNeighbourhood = "Darussafaka" //Mahalle
        /* Adres template
         https://maps.googleapis.com/maps/api/distancematrix/json?departure_time=now&destinations=Zekeriyaköy%2CSarıyer&origins=Darüşşafaka%2CSarıyer&key=AIzaSyCLXimH0q_oPpTDAJClzfM2RdJlZs-ZV34
         */
        
        var finalUrl = "https://maps.googleapis.com/maps/api/distancematrix/json?departure_time=now&destinations=" + toNeighbourhood + "%2C" + toTown + "%7CIstanbul%2CTurkiye&origins=" + fromNeighbourhood + "%2C" + fromTown + "%7CIstanbul%2CTurkiye&key=AIzaSyCLXimH0q_oPpTDAJClzfM2RdJlZs-ZV34"
        
        let url = "https://maps.googleapis.com/maps/api/distancematrix/json?departure_time=now&destinations=Asik%2CVeysel%2CAtasehir%7CIstanbul%2CTurkiye&origins=Darussafaka%2CSariyer%7CIstanbul%2CTurkiye&key=AIzaSyCLXimH0q_oPpTDAJClzfM2RdJlZs-ZV34"
        var resp = ""
        URLSession.shared.dataTask(with: NSURL(string: finalUrl)! as URL) { data, response, error in
            resp = String( data:data!, encoding:String.Encoding(rawValue: NSUTF8StringEncoding) )!
            print(resp)
            var flag = 0
            var index = 0
            var distance = ""
            for char in resp {
                if (flag >= 4){
                    if (flag >= 9){
                        if(char == " "){
                            break
                        }
                        if(char==","){
                            distance = distance + "."
                        } else {
                            distance = distance + String(char)
                        }
                        
                    }
                    flag = flag + 1
                }
                if (char == "t" && flag == 0){
                    flag = flag+1
                }
                 else if (flag == 1){
                    print("flag is one")
                    print(char)
                    if(char == "e"){
                        flag = flag+1
                        print("e found")
                        print(flag)

                    } else {
                        flag = 0
                    }
                }
                else if (flag == 2){
                    if(char == "x"){
                        flag = flag+1
                        print("x found")
                        print(flag)

                    } else {
                        flag = 0
                    }
                }
                else if (flag == 3){
                    if(char == "t"){
                        flag = flag+1
                        print("t found")
                        print(flag)

                    } else {
                        flag = 0
                    }
                }
                
                

            }
            let numberFormatter = NumberFormatter()
            let number = numberFormatter.number(from: distance)
            let numberFloatValue = number?.floatValue
            print("FOUND DISTANCE")
            print( (numberFloatValue as! Float)+2)
            
            

        }.resume()*/
        
       
        
    }
    
    func getNumberOfRides() -> Int {
        return ridesArray.count
    }
    
    func getRide(for index: Int) -> Ride? {
        guard index < ridesArray.count else {
            return nil
        }
        return ridesArray[index]
    }
    
    func sortTheRideArray(){
        for ride in self.ridesArray{
            let db = Firestore.firestore()
            let docRef = db.collection("users").document(ride.mail)
            var riderSmokingPreference = false
           docRef.getDocument { (document, error) in
               if let document = document, document.exists {
                   riderSmokingPreference = document.get("smokingFlag")! as! Bool
                   // set the chattiness and smoking
                   print("In database")
                   print(ride.mail)
                   print(riderSmokingPreference)
               } else {
                   
               }
           }
            
            
        }
    }
    
}

