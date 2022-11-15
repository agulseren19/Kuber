//
//  SignUpViewController.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 10.11.2022.
//

import UIKit
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

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func continueButtonIsClicked(_ sender: Any) {
        let email = emailField.text!
        let password = passwordField.text!
        
                Auth.auth().createUser(withEmail: email,
                                       password: password) { user, error in
                    if error == nil {
                        Auth.auth().currentUser?.sendEmailVerification { (error) in
                        }}}
                        let db = Firestore.firestore()
                       // var ref: DocumentReference? = nil
        
                db.collection("users").document(email).setData([

                    "email": email,
                    "password": password,

                ]) { err in

                    if let err = err {

                        print("Error writing document: \(err)")

                    } else {

                        print("Document successfully written!")

                    }
                }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let secondSignUpViewController = segue.destination as? SecondSignUpViewController{
            secondSignUpViewController.userEmail = emailField.text!
        }
    }
    

}
