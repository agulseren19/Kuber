//
//  ViewController.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 25.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var fullNameInputField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func signUpButtonClicked(_ sender: UIButton) {
      let fullName = fullNameInputField.text
    }
    
}

