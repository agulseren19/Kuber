//
//  SignUpViewController.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 10.11.2022.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var passwordInputField: UITextField!
    @IBOutlet weak var emailInputField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        let email = emailInputField.text!
                let password = passwordInputField.text!
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
