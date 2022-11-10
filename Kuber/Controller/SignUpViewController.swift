//
//  SignUpViewController.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 10.11.2022.
//

import UIKit

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
