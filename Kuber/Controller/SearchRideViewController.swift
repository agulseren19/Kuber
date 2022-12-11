//
//  SearchRideViewController.swift
//  Kuber
//
//  Created by Begum Sen on 30.10.2022.
//

import UIKit

class SearchRideViewController: UIViewController {
    
    @IBOutlet weak var toLocation: UITextField!
    @IBOutlet weak var fromLocation: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var showAllSwitch: UISwitch!
    @IBOutlet weak var showAllLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showAllLabel.tag = 001
        
    }
    
   
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        let from = fromLocation.text
        let to = toLocation.text
        let date = datePicker.date
        let time = timePicker.date
        let all = showAllSwitch.isOn
        
        let ridesViewController = self.storyboard?.instantiateViewController(withIdentifier: "RidesViewController") as! RidesViewController
                ridesViewController.from = fromLocation.text!
                ridesViewController.to = toLocation.text!
                ridesViewController.date = date
                ridesViewController.time = time
                ridesViewController.all = all
                self.navigationController?.pushViewController(ridesViewController, animated:true)
        //print(from)
        //print(to)
        //print(date)
        //print(time)
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
