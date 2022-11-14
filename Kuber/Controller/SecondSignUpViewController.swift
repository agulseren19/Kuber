//
//  ViewController.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 25.10.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseCore
import FirebaseCore
import GoogleSignIn
import FirebaseCore
import FirebaseFirestore
class SecondSignUpViewController: UIViewController {

    @IBOutlet weak var fullNameInputField: UITextField!
    @IBOutlet weak var phoneNumberInputField: UITextField!
    @IBOutlet weak var majorInputField: UITextField!
    
    @IBOutlet weak var checkboxSmoking: UIButton!
    
    @IBOutlet weak var checkboxChattiness: UIButton!
    
    @IBOutlet weak var gradeSegmentedControl: UISegmentedControl!
    var smokingFlag=false
    var chattinessFlag=false
    let signUpHelper = SignUpHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //set font of segmented control
        let font=UIFont.systemFont(ofSize: 8)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        signUpHelper.delegate = self

    }


    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        
        let user = User.sharedInstance
        user.setFullName(fullName: fullNameInputField.text!)
        user.setPhoneNumber(phoneNumber: phoneNumberInputField.text!)
        user.setMajor(major: majorInputField.text!)
        let segmentIndex = gradeSegmentedControl.selectedSegmentIndex
        if segmentIndex==0 {
            user.setClassLevel(classLevel: "ELC")
        }
        if segmentIndex==1 {
            user.setClassLevel(classLevel: "Freshman")
        }
        if segmentIndex==2 {
            user.setClassLevel(classLevel: "Sophomore")
        }
        if segmentIndex==3 {
            user.setClassLevel(classLevel: "Junior")
        }
        if segmentIndex==4 {
            user.setClassLevel(classLevel: "Senior")
        }
        let db = Firestore.firestore()
        db.collection("users").document(user.getEmail()).updateData([

                    "smokingFlag": smokingFlag,
                    
                    "fullName": fullNameInputField.text!,
                    "phoneNumber": phoneNumberInputField.text!,
                    "major": majorInputField.text!,
                    "classLevel": user.getClassLevel(),

                    "chattinessFlag": chattinessFlag,

                ]) { err in

                    if let err = err {

                        print("Error writing document: \(err)")

                    } else {

                        print("Document successfully written!")

                    }

                }
        
        
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
extension SecondSignUpViewController: SignUpDelegate {
    func setUI(){
        
    }
    
}

