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
class SignUpViewController: UIViewController {

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
        let fullName = fullNameInputField.text!
                let phoneNumber = phoneNumberInputField.text!
                let major = majorInputField.text!
                let db = Firestore.firestore()
                var ref: DocumentReference? = nil
                ref = db.collection("users").addDocument(data: [
                    "fullName": fullName,
                    "phoneNumber": phoneNumber,
                    "major": major
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }
        
        
        Auth.auth().createUser(withEmail: fullName,
                               password: major) { user, error in
            if error == nil {
                Auth.auth().currentUser?.sendEmailVerification { (error) in
                }}}
        
            
        if (Auth.auth().currentUser?.isEmailVerified != nil){
            Auth.auth().signIn(withEmail: fullName, password: major) { [weak self] authResult, error in
                if error == nil {
                    print("girdi")
                } else {
                    print("giremedi")
                }
                // ...
            }
        }
        
        /*guard let clientID = FirebaseApp.app()?.options.clientID else { return }

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
        
        let firebaseAuth = Auth.auth()
       do {
         try firebaseAuth.signOut()
       } catch let signOutError as NSError {
         print("Error signing out: %@", signOutError)
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

