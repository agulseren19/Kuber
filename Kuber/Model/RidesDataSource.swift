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
    var globalDistance = 0.0
    private var rideSearchArray: [RideSearch] = []
   
    
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
                    
                    var newRide = Ride (
                        rideId: document.documentID,
                        fromLocation: document.get("from") as! String,
                        fromNeighbourhoodLocation: document.get("fromNeighbourhood") as! String,
                        toLocation: document.get("to") as! String,
                        toNeighbourhoodLocation: document.get("toNeighbourhood") as! String,
                        date: (document.get("date") as! Timestamp).dateValue(),
                        time: (document.get("time") as! Timestamp).dateValue(),
                        seatAvailable: document.get("numberOfSeats") as! Int,
                        fee: document.get("fee") as! Int,
                        mail: document.get("mail") as! String,
                        hitched: User.sharedInstance.getMyHitchesToRideIdArray().contains(document.documentID)
                    )
                    
                    self.ridesArray.append(newRide)
                    self.ridesArray = self.ridesArray.filter{ $0.mail != User.sharedInstance.getEmail() }
                    self.ridesArray = self.ridesArray.filter{ $0.date >  Date() }
                    print("X")
                    
                    mutex = mutex + 1
                    if (mutex == self.rideCount){
                        DispatchQueue.main.async {
                            print("count: \(self.ridesArray.count)")
                            self.getRiderInfo()
                            print("Y")
                        }
                    }
                }
                print("Z")
            }
        }
    }
    
    
    func getListOfRidesWithoutShowAll(to: String, toNeighbourhood: String, date: Date, time: Date ) {
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
                    
                    var newRide = Ride (
                        rideId: document.documentID,
                        fromLocation: document.get("from") as! String,
                        fromNeighbourhoodLocation: document.get("fromNeighbourhood") as! String,
                        toLocation: document.get("to") as! String,
                        toNeighbourhoodLocation: document.get("toNeighbourhood") as! String,
                        date: (document.get("date") as! Timestamp).dateValue(),
                        time: (document.get("time") as! Timestamp).dateValue(),
                        seatAvailable: document.get("numberOfSeats") as! Int,
                        fee: document.get("fee") as! Int,
                        mail: document.get("mail") as! String,
                        hitched: User.sharedInstance.getMyHitchesToRideIdArray().contains(document.documentID)
                    )
                    
                    self.ridesArray.append(newRide)
                    print("X")
                    
                    mutex = mutex + 1
                    if (mutex == self.rideCount){
                        DispatchQueue.main.async {
                            self.sortTheRideArray( to: to , toNeighbourhood: toNeighbourhood , date: date , time: time  )
                            //self.delegate?.ridesListLoaded()
                            //self.getRiderInfo()
                            print("Y")
                            print("ride size")
                            print(self.getNumberOfRides())
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
    
    func getRiderInfo (){
        rideSearchArray.removeAll()
        let db = Firestore.firestore()
        var mutex = 0
        for i in 0..<ridesArray.count {
            var ride = ridesArray[i]
            var riderMail = ride.mail
            let docRef2 = db.collection("users").document(riderMail)
            docRef2.getDocument { (document, error) in
                if let document = document, document.exists {
                    var newRideSearch = RideSearch(
                        ride: ride,
                        riderFullName: document.get("fullName") as! String,
                        riderMajor: document.get("major") as! String
                    )
                    self.rideSearchArray.append(newRideSearch)
                    print("A")
                    mutex = mutex + 1
                    if (mutex == self.ridesArray.count){
                        DispatchQueue.main.async {
                            self.delegate?.ridesListLoaded()
                        }
                        print("C")
                    }
                    
                } else {
                    print("Document does not exist in my Ride")
                }
                
            }
            
        }
    }
    
    func getNumberOfRides() -> Int {
        return rideSearchArray.count
    }
    
    func getRide(for index: Int) -> RideSearch? {
        guard index < rideSearchArray.count else {
            return nil
        }
        return rideSearchArray[index]
    }
    
    
    func sortTheRideArray( to: String, toNeighbourhood: String, date: Date, time: Date  ){
        var ridePointDictionary = [Ride: Double]()
        var sortedRidesArray: [Ride] = []
        var sortedArrayCounter = 0
       var counter = 0
        self.ridesArray = self.ridesArray.filter{ $0.mail != User.sharedInstance.getEmail() }
        for var ride in self.ridesArray{
            let db = Firestore.firestore()
            
            var ridePoint = 0.0
            let docRef = db.collection("users").document(ride.mail)
            var riderSmokingPreference = false
            var riderChattinessPreference = false
            var riderClassLevel = ""
            var riderSmokeMatch = false
            var riderChatMatch = false
            var ridersMatch = false
            var riderMajor = ""
           docRef.getDocument { (document, error) in
               if let document = document, document.exists {
                   riderSmokingPreference = document.get("smokingFlag")! as! Bool
                   riderChattinessPreference = document.get("chattinessFlag")! as! Bool
                   riderClassLevel = document.get("classLevel")! as! String
                   riderMajor = document.get("classLevel")! as! String
                   if (riderSmokingPreference == User.sharedInstance.getSmokingPreference()){
                            riderSmokeMatch = true
                    }
                    if (riderChattinessPreference == User.sharedInstance.getChattinessPreference()){
                            riderChatMatch = true
                    }
                    if (riderSmokeMatch == true) && (riderChatMatch == true){
                            ridersMatch = true
                    }
                   print("Hithcher TO")
                   print(to)
                   print("Hithcher NeighbourHood")
                   print(toNeighbourhood)
                   print("Hithcher Date")
                   print(date)
                   print("Hithcher Time")
                   print(time)
                   print("rideLocation")
                   print(ride.toLocation)
                   print("ride Neigh Location")
                   print(ride.toNeighbourhoodLocation)
                   var hitchhikerToTown = to//ilçe
                   var hitchhikerToNeighbourhood = toNeighbourhood //Mahalle
                   
                 
                   
                   
                   
                   var riderToTown = ride.toLocation//ilçe
                   var riderToNeighbourhood = ride.toNeighbourhoodLocation //Mahalle
                   print("hitchhikerToNeighbourhood")
                   print(hitchhikerToNeighbourhood)
                   print("hitchhikerToTown")
                   print(hitchhikerToTown)
                   if(riderToNeighbourhood == "Ana Kampüs"){
                       riderToTown = "Sarıyer"
                       riderToNeighbourhood = "Koç Üniversitesi"
                   } else if (riderToNeighbourhood == "Batı Kampüs"){
                       riderToTown = "Sarıyer"
                       riderToNeighbourhood = "Koç Üniversitesi Batı Kampüsü"
                   }
                   if(toNeighbourhood == "Ana Kampüs"){
                       hitchhikerToTown = "Sarıyer"
                       hitchhikerToNeighbourhood = "Koç Üniversitesi"
                   } else if (toNeighbourhood == "Batı Kampüs"){
                       hitchhikerToTown = "Sarıyer"
                       hitchhikerToNeighbourhood = "Yediveren Sokak"
                   }
                   hitchhikerToTown = self.parseAddress(address: hitchhikerToTown)
                   hitchhikerToNeighbourhood = self.parseAddress(address: hitchhikerToNeighbourhood)
                   riderToTown = self.parseAddress(address: riderToTown)
                   riderToNeighbourhood = self.parseAddress(address: riderToNeighbourhood)
                   print("hitchhikerToNeighbourhood")
                   print(hitchhikerToNeighbourhood)
                   print("hitchhikerToTown")
                   print(hitchhikerToTown)
                   print("riderToNeighbourhood")
                   print(riderToNeighbourhood)
                   print("riderToTown")
                   print(riderToTown)
                   /* Adres template
                    https://maps.googleapis.com/maps/api/distancematrix/json?departure_time=now&destinations=Zekeriyaköy%2CSarıyer&origins=Darüşşafaka%2CSarıyer&key=AIzaSyCLXimH0q_oPpTDAJClzfM2RdJlZs-ZV34
                    */
                   
                   var finalUrl = "https://maps.googleapis.com/maps/api/distancematrix/json?departure_time=now&destinations=" + riderToNeighbourhood + "%2C" + riderToTown + "%7CIstanbul%2CTurkiye&origins=" + hitchhikerToNeighbourhood + "%2C" + hitchhikerToTown + "%7CIstanbul%2CTurkiye&key=AIzaSyCLXimH0q_oPpTDAJClzfM2RdJlZs-ZV34"
                   
                   let url = "https://maps.googleapis.com/maps/api/distancematrix/json?departure_time=now&destinations=Asik%2CVeysel%2CAtasehir%7CIstanbul%2CTurkiye&origins=Darussafaka%2CSariyer%7CIstanbul%2CTurkiye&key=AIzaSyCLXimH0q_oPpTDAJClzfM2RdJlZs-ZV34"
                   var resp = ""
                   var result = 0.0
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
                       var distanceBetweenDestinations = numberFloatValue
                       var riderClassLevelInt = 0
                        if (riderClassLevel == "ELC"){
                                riderClassLevelInt = 0
                        }
                        if (riderClassLevel == "Freshman"){
                                riderClassLevelInt = 1
                        }
                        if (riderClassLevel == "Sophomore"){
                                riderClassLevelInt = 2
                        }
                        if (riderClassLevel == "Junior"){
                                riderClassLevelInt = 3
                        }
                        if (riderClassLevel == "Senior"){
                                riderClassLevelInt = 4
                        }
                       var userClassLevelInt = 0
                                              
                        if (User.sharedInstance.getClassLevel() == "ELC"){
                                userClassLevelInt = 0
                        }
                        if (User.sharedInstance.getClassLevel() == "Freshman"){
                                    userClassLevelInt = 1
                        }
                        if (User.sharedInstance.getClassLevel() == "Sophomore"){
                                    userClassLevelInt = 2
                        }
                        if (User.sharedInstance.getClassLevel() == "Junior"){
                                    userClassLevelInt = 3
                        }
                            if (User.sharedInstance.getClassLevel() == "Senior"){
                                    userClassLevelInt = 4
                            }
                                              
                       var classDifference = abs(userClassLevelInt-riderClassLevelInt)
                       print("FOUND DISTANCE")
                       
                       ridePoint = ridePoint - Double(numberFloatValue!)
                       print("RIDE POINTT")
                       ridePoint = ridePoint - Double(classDifference)
                       ridePoint = ridePoint - (Double(ride.fee)/5)
                       print(ridePoint)
                       /*let rideTime = ride.time
                       var calendar = Calendar.current
                       let hour = calendar.component(.hour, from: rideTime)
                       let minute = calendar.component(.minute, from: rideTime)*/
                       var calendar = Calendar.current
                       var hitcherDateSelectionDay = calendar.component(.day, from: date)
                       var hitcherDateSelectionMonth = calendar.component(.month, from: date)
                       var hitcherDateSelectionYear = calendar.component(.year, from: date)
                       var hitcherHourSelection = calendar.component(.hour, from: time)
                       var hitcherMinuteSelection = calendar.component(.minute, from: time)
                       var rideDateYear = calendar.component(.year, from: ride.date)
                       var rideDateMonth = calendar.component(.month, from: ride.date)
                       var rideDateDay = calendar.component(.day, from: ride.date)
                       var rideTimeHour = calendar.component(.hour, from: ride.time)
                       var rideTimeMinute = calendar.component(.minute, from: ride.time)

                       
                       var rideTime = ride.time
                       print("hitcherDateSelectionDay, hitcherDateSelectionmonth , hitcherDateSelectionyear :")
                       print(hitcherDateSelectionDay)
                       print(hitcherDateSelectionMonth)
                       print(hitcherDateSelectionYear)
                       print("hitcherHourSelectionHour:")
                       print(hitcherHourSelection)
                       print("hitcherMinuteSelection:")
                       print(hitcherMinuteSelection)
                       print("ridedateYear, ridedateMonth , ridedateDay :")
                       print(rideDateDay)
                       print(rideDateMonth)
                       print(rideDateYear)
                       print("rideTimeHour, rideTimeMinute  :")
                       print(rideTimeHour)
                       print(rideTimeMinute)
                      
                       ridePoint = ridePoint - Double(distanceBetweenDestinations!)
                       var timeDifferenceHour = rideTimeHour - hitcherHourSelection
                       var timeDifferenceMinute = rideTimeMinute - hitcherMinuteSelection
                       var timeDifferenceInMinutes = abs(60*timeDifferenceHour+timeDifferenceMinute)
                       ridePoint = ridePoint - Double(timeDifferenceInMinutes*10)
                       if(riderMajor == User.sharedInstance.getMajor()){
                           ridePoint = ridePoint + 2
                       }
                       if(rideDateDay == hitcherDateSelectionDay ) && (rideDateMonth == hitcherDateSelectionMonth ) && (rideDateYear == hitcherDateSelectionYear )  {
                           ridePointDictionary[ride] = ridePoint
                       }
                       
                       var sortedByValueDictionary = ridePointDictionary.sorted { $0.1 > $1.1 }
                       
                       /*sortedByValueDictionary = sortedByValueDictionary.filter{ $0 != $1  }
                       print(sortedByValueDictionary)*/
                       counter = counter + 1
                       if(counter == self.ridesArray.count){
                           for (rideKey , ridePoint2 ) in sortedByValueDictionary {
                               if((sortedArrayCounter < 5)&&(!sortedRidesArray.contains(rideKey))/*&&ridersMatch*/){
                                   
                                   print("append should happen here")
                                   sortedRidesArray.append(rideKey)
                                   sortedArrayCounter = sortedArrayCounter + 1
                               }
                           }
                           print("sorted ride array:")
                           self.ridesArray = sortedRidesArray
                           print(sortedRidesArray)
                           //self.delegate?.ridesListLoaded()
                           self.getRiderInfo()
                       }
                       
                       
                      

                   }.resume()
                   
               } else {
                   
               }
           }
            
        }
    }
    
    func parseAddress(address: String) -> String {
            var parsedAddress = address
            parsedAddress = parsedAddress.replacingOccurrences(of: " ", with: "%2C")
            parsedAddress = parsedAddress.replacingOccurrences(of: "ı", with: "i")
            parsedAddress = parsedAddress.replacingOccurrences(of: "Ğ", with: "G")
            parsedAddress = parsedAddress.replacingOccurrences(of: "ğ", with: "g")
            parsedAddress = parsedAddress.replacingOccurrences(of: "Ü", with: "U")
            parsedAddress = parsedAddress.replacingOccurrences(of: "ü", with: "u")
            parsedAddress = parsedAddress.replacingOccurrences(of: "Ş", with: "S")
            parsedAddress = parsedAddress.replacingOccurrences(of: "ş", with: "s")
            parsedAddress = parsedAddress.replacingOccurrences(of: "İ", with: "I")
            parsedAddress = parsedAddress.replacingOccurrences(of: "Ö", with: "O")
            parsedAddress = parsedAddress.replacingOccurrences(of: "ö", with: "o")
            parsedAddress = parsedAddress.replacingOccurrences(of: "Ç", with: "C")
            parsedAddress = parsedAddress.replacingOccurrences(of: "ç", with: "c")
            print("prsed address")
            print(parsedAddress)
            return parsedAddress
        }
}
