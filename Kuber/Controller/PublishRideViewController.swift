//
//  PublishRideViewController.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 3.11.2022.
//

import UIKit
import Foundation

class PublishRideViewController: UIViewController {

    @IBOutlet weak var fromLocation: UITextField!
    
    @IBOutlet weak var toLocation: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    
    @IBOutlet weak var feeField: UITextField!
    
    @IBOutlet weak var numberOfSeatsField: UISegmentedControl!
    
    let publishRideHelper = PublishRideHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        publishRideHelper.delegate = self
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
        publishRideHelper.saveRide(from: from, to: to, date: date, time: time, fee: fee, numberOfSeats: numberOfSeats)
    
    
}
}
extension PublishRideViewController: PublishRideDelegate {
    func publishedToDatabase(){
        print("aaaaaaaaa")
        let myRidesViewController: UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyRidesViewController") as! MyRidesViewController
        self.navigationController?.pushViewController(myRidesViewController, animated: true)
    }
}
