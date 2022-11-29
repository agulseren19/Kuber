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
    
    @IBOutlet weak var errorText: UILabel!
    
    let signInHelper = SignInHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.isSecureTextEntry = true
        signInHelper.delegate = self
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
       
        signInHelper.checkAndSignIn(userEmail: userEmail, userPassword: userPassword)
    }
    
    
}

extension LogInViewController: SignInDelegate {
    func signInTheUser() {
        // if the user's email and password is validated
        // the user will be signed in and navigated to home screen
        
        var tabBar: UITabBarController = self.storyboard?.instantiateViewController(withIdentifier: "Tabbar") as! UITabBarController
        self.navigationController?.pushViewController(tabBar, animated: true)
        
        errorText.text = ""
        passwordField.text = ""
        emailField.text = ""
    }
    
    func giveSignInError( errorDescription: String) {
        print(errorDescription)
        errorText.text = errorDescription
        errorText.isHidden = false
        errorText.textColor = UIColor.red
        errorText.adjustsFontSizeToFitWidth = true
    }
}
