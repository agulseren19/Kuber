//
//  PublishRideViewController.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 3.11.2022.
//

import UIKit
import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseCore
import FirebaseCore
import GoogleSignIn
import FirebaseCore
import FirebaseFirestore
class PublishRideViewController: UIViewController {

    @IBOutlet weak var fromLocation: UITextField!
    
    @IBOutlet weak var toLocation: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    
    @IBOutlet weak var feeField: UITextField!
    
    @IBOutlet weak var numberOfSeatsField: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func publishButtonClicked(_ sender: UIButton) {
        let from = fromLocation.text!
        let to = toLocation.text!
        let date = datePicker.date
        let time = timePicker.date
        let fee = feeField.text!
        let numberOfSeats=numberOfSeatsField.selectedSegmentIndex+1
        let db = Firestore.firestore()
        let id = db.collection("rides").document().documentID;
        var ride: Ride
        ride.setFrom(from: (Any).self)
        ride.setTo(to: (Any).self)
        ride.setDate(date: <#T##Any#>)
        ride.setTime(time: <#T##Any#>)
        ride.setFee(fee: <#T##Any#>)
        ride.setNumberOfSeats(numberOfSeats: <#T##Any#>)
        db.collection("rides").document(id).setData([

            //"id" = user ride publish ettiğinde random id ata
            "from": fromLocation.text!,
            "to": toLocation.text!,
            "date": datePicker.date,
            "time": timePicker.date,
            "fee": feeField.text!,
            "numberOfSeats": numberOfSeatsField.selectedSegmentIndex+1,
            "mail" :User.sharedInstance.getEmail(),
            

        ]) { err in

            if let err = err {

                print("Error writing publish data: \(err)")

            } else {

                print("Publish data successfully written!")

            }
        }
        
        let docRef = db.collection("users").document(User.sharedInstance.getEmail())
       docRef.getDocument { (document, error) in
           if let document = document, document.exists {
               docRef.updateData([
                   "publishedRides": FieldValue.arrayUnion([id])

               ])
           } else {
               print("Document does not exist")
           }
       }
        
    
        
        User.sharedInstance.appendToRideArray(id: id)
        
        print(User.sharedInstance.getRideArray()[2])
        
        
        /*let ref = db.collection("rides").addDocument(data: [
                            //"id" = user ride publish ettiğinde random id ata
                            "from": fromLocation.text!,
                            "to": toLocation.text!,
                            "date": datePicker.date,
                            "time": timePicker.date,
                            "fee": feeField.text!,
                            "numberOfSeats": numberOfSeatsField.selectedSegmentIndex+1,
                            "mail" :User.sharedInstance.getEmail(),

                        ]) { err in

                            if let err = err {

                                print("Error writing publish data: \(err)")

                            } else {

                                print("Publish data successfully written!")

                            }

                        }*/
        
       
       /* let docRef = db.collection("rides").document(ref.name)
//usera ride id yaz
       docRef.getDocument { (document, error) in
           if let document = document, document.exists {
               print(document.get("fee")!)
           } else {
               print("Document does not exist")
           }
       }*/

    }
    
    
}
