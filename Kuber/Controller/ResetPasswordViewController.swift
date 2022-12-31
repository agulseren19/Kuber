//
//  ResetPasswordViewController.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 31.12.2022.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UITextField!
    let resetPasswordHelper = ResetPasswordHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        resetPasswordHelper.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendButtonClicked(_ sender: Any) {
        guard let userEmail = emailLabel.text
        else{
            return
        }
        resetPasswordHelper.checkAndSend(userEmail: userEmail)

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
extension ResetPasswordViewController: ResetPasswordDelegate {
    func sentNavigateBack() {
        //self.navigationController?.popToRootViewController(animated: true)
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if aViewController is LogInViewController {
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
        emailLabel.text = ""
    }
    
    func giveSendError( errorDescription: String) {
        errorLabel.text = errorDescription
        errorLabel.isHidden = false
        errorLabel.textColor = UIColor.red
        errorLabel.adjustsFontSizeToFitWidth = true
    }
}
