//
//  ViewController.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 25.10.2022.
//

import UIKit

class SecondSignUpViewController: UIViewController {

    @IBOutlet weak var fullNameInputField: UITextField!
    @IBOutlet weak var phoneNumberInputField: UITextField!
    @IBOutlet weak var majorInputField: UITextField!
    
    @IBOutlet weak var checkboxSmoking: UIButton!
    
    @IBOutlet weak var checkboxChattiness: UIButton!
    
    @IBOutlet weak var gradeSegmentedControl: UISegmentedControl!
    var smokingFlag=false
    var chattinessFlag=false
    let secondSignUpHelper = SecondSignUpHelper()
    
    var userEmail: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //set font of segmented control
        let font=UIFont.systemFont(ofSize: 8)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        secondSignUpHelper.delegate = self

    }
    


    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        let fullName = fullNameInputField.text!
        let phoneNumber = phoneNumberInputField.text!
        let major = majorInputField.text!
        let segmentIndex = gradeSegmentedControl.selectedSegmentIndex
        secondSignUpHelper.signUp(fullName: fullName, phoneNumber: phoneNumber, major: major, segmentIndex: segmentIndex, smokingFlag: smokingFlag, chattinessFlag: chattinessFlag, userEmail: userEmail)
        
        /*
         let db = Firestore.firestore()
         let docRef = db.collection("users").document(user.getEmail())

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                print(document.get("password")!)
            } else {
                print("Document does not exist")
            }
        }*/

                   
               
    }
    
    @IBAction func smokingCheckBoxClicked(_ sender: UIButton) {
        if(smokingFlag==true){
            sender.setImage((UIImage(named:"uncheckedCheckbox")), for: .normal)
            smokingFlag=false
        }
        else{
            sender.setImage((UIImage(named:"checkedCheckbox")), for: .normal)
            smokingFlag=true
        }
    }
    
    @IBAction func chattinessCheckBoxClicked(_ sender: UIButton) {
        if(chattinessFlag==true){
            sender.setImage((UIImage(named:"uncheckedCheckbox")), for: .normal)
            chattinessFlag=false
        }
        else{
            sender.setImage((UIImage(named:"checkedCheckbox")), for: .normal)
            chattinessFlag=true
        }
    }
 
}
extension SecondSignUpViewController: SecondSignUpDelegate {
    func makeFieldsEmpty(){
        fullNameInputField.text = ""
        phoneNumberInputField.text = ""
        majorInputField.text = ""
    }
}

