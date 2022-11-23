//
//  User.swift
//  Kuber
//
//  Created by UTKU on 14.11.2022.
//

import Foundation

final class Ride: NSObject {
    
    var date : Any = ""
    var fee : Any = ""
    var from : Any = ""
    var to : Any = ""
    var mail : Any = ""
    var numberOfSeats : Any = ""
    var time : Any = ""
    

   private override init() { }

    func setDate(date : Any) {
       self.date = date
   }
    
    func getDate() -> Any {
        return self.date
    }
    
    func setFee(fee : Any) {
        self.fee = fee
    }
     
     func getFee() -> Any {
         return self.fee
     }
    
    func setFrom(from : Any) {
        self.from = from
    }
     
     func getFrom() -> Any {
         return self.from
     }
    
    func setTo(to : Any) {
        self.to = to
    }
     
     func getTo() -> Any {
         return self.to
     }
    func setMail(mail : Any) {
        self.mail = mail
    }
   
     
     func getMail() -> Any {
         return self.mail
     }
    
    func getNumberOfSeats() -> Any {
        return self.numberOfSeats
    }
   func setNumberOfSeats(numberOfSeats : Any) {
       self.numberOfSeats = numberOfSeats
   }
    
    func getTime() -> Any {
        return self.time
    }
   func setTime(time : Any) {
       self.time = time
   }
    
}
