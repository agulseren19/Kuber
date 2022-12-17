//
//  SignUpViewController.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 10.11.2022.
//

import UIKit


class SignUpViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var uploadImageButton: UIButton!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var passwordField: UITextField!
    
    private var profileImage: UIImage = UIImage(named: "defaultProfile")!
    private var profileImageUrl: String = "https://firebasestorage.googleapis.com/v0/b/kuber-2f5b0.appspot.com/o/images%2F_defaultProfile_.png?alt=media&token=6f9e9fb4-02a9-49fb-960f-275bf07e7a5d"
    
    
    @IBOutlet weak var errorText: UILabel!
    let signUpHelper = SignUpHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.isSecureTextEntry=true
        signUpHelper.delegate = self
        //emailField.delegate = self
        //passwordField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func continueButtonIsClicked(_ sender: Any) {
        let email = emailField.text!
        let password = passwordField.text!
        signUpHelper.createAndSaveUser(email:email,password:password,profileImageUrl: self.profileImageUrl)
        guard let imageData = profileImage.pngData() else {
            return
        }
        signUpHelper.setImageUrl(email: email, imageData: imageData)
    }
    
    
    @IBAction func uploadImageClicked(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let secondSignUpViewController = segue.destination as? SecondSignUpViewController{
            secondSignUpViewController.userEmail = emailField.text!
        }
    }
*/
}
extension SignUpViewController: SignUpDelegate {
    func signUpTheUser() {
        // if the user's email and password is validated
        // the user will be signed up and navigated to next screen
        let secondSignUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondSignUpViewController") as! SecondSignUpViewController
        secondSignUpViewController.userEmail=self.emailField.text!
        self.navigationController?.pushViewController(secondSignUpViewController, animated:true)
        errorText.text = ""
        passwordField.text = ""
        emailField.text = ""
    }
    
    func giveSignUpError( errorDescription: String) {
        print(errorDescription)
        errorText.text = errorDescription
        errorText.isHidden = false
        errorText.textColor = UIColor.red
        errorText.adjustsFontSizeToFitWidth = true
    }
}

extension SignUpViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profileImage = image
        } else{
            print("can't pick image")
            return
        }
        
        self.profileImageView.image = self.profileImage
        self.profileImageView.layer.borderWidth = 1.0
        self.profileImageView.layer.masksToBounds = false
        self.profileImageView.layer.borderColor = UIColor.white.cgColor
        print("width: \(self.profileImageView.frame.width)")
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
        self.profileImageView.clipsToBounds = true
        
        
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }

}

extension SignUpViewController: UINavigationControllerDelegate{
    
}
