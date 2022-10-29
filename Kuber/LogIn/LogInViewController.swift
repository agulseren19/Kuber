//
//  LogInViewController.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 28.10.2022.
//

import UIKit

class LogInViewController: UIViewController {

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


    @IBAction func logInButtonClicked(_ sender: UIButton) {
        let signUpViewController:UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        //log in using firebase here
        //if succesful login and first time user
        print(self.navigationController)
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
}
