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

    @IBOutlet weak var hitchImage: UIImageView!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var errorText: UILabel!
    
    let signInHelper = SignInHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //passwordField.isSecureTextEntry = true
        signInHelper.delegate = self
        //emailField.delegate = self
        //passwordField.delegate = self
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
              NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

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
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let  hitchImage=hitchImage , let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      
      // move the root view up by the distance of keyboard height
      self.view.frame.origin.y = 0 - keyboardSize.height
        hitchImage.isHidden=true

    }
    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
        hitchImage.isHidden=false

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

/*extension LogInViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}*/
