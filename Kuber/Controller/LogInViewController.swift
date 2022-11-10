//
//  LogInViewController.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 28.10.2022.
//

import UIKit
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

class LogInViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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

    @IBAction func signInButtonClicked(_ sender: Any) {
        let userEmail = emailField.text!
        let userPassword = passwordField.text!
        /*let db = Firestore.firestore()
        let docRef = db.collection("users").document(userEmail)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
        print("SignIn Button Clicked")*/
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { (authResult, error) in
          if let authResult = authResult {
            let user = authResult.user
            if user.isEmailVerified {
                print("Email is verified, now you are signed in as " + userEmail)
            } else {
              // do whatever you want to do when user isn't verified
                print("Cant Sign in user. Verification needed")
            }
          }
          if let error = error {
          }
        }
    }
    
    
    @IBAction func logInButtonClicked(_ sender: UIButton) {
      //  let signUpViewController:UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        //log in using firebase here
        //if succesful login and first time user
        //print(self.navigationController)
        //self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
}
