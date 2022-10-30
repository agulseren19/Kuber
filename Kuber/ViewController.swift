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
// ...
      
class ViewController: UIViewController {

    @IBOutlet weak var fullNameInputField: UITextField!
    @IBOutlet weak var phoneNumberInputField: UITextField!
    @IBOutlet weak var majorInputField: UITextField!
    
    @IBOutlet weak var checkboxSmoking: UIButton!
    
    @IBOutlet weak var checkboxChattiness: UIButton!
    
    @IBOutlet weak var gradeSegmentedControl: UISegmentedControl!
    var smokingFlag=false
    var chattinessFlag=false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //set font of segmented control
        let font=UIFont.systemFont(ofSize: 8)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)

    }


    @IBAction func signUpButtonClicked(_ sender: UIButton) {
      let fullName = fullNameInputField.text
        let phoneNumber = phoneNumberInputField.text
        let major = majorInputField.text
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

          if let error = error {
            // ...
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)

          // ...
            
            Auth.auth().signIn(with: credential) 
        }
       
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

