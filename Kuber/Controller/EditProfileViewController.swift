//
//  EditProfileViewController.swift
//  Kuber
//
//  Created by Arda Aliz on 16.12.2022.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var fullNameInputField: UITextField!
    @IBOutlet weak var phoneNumberInputField: UITextField!
    @IBOutlet weak var gradeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var checkBoxSilentRide: UIButton!
    @IBOutlet weak var checkBoxNoSmoking: UIButton!
    @IBOutlet weak var majorInputField: UIButton!
    
    @IBOutlet weak var errorText: UILabel!
    @IBOutlet weak var uploadImageButton: UIButton!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    private var profileImage: UIImage = UIImage(named: "defaultProfile")!
    // Initialization values
    private var noSmokingFlag: Bool = true
    private var silentRideFlag: Bool = true
    var userEmail: String = ""
    
    
    //I am using the SecondSignUPHelper class because the reasoning behind creating profile and editing it is same.
    let profilePictureHelper = ProfilePictureHelper()
    let secondSignUpHelper = SecondSignUpHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        fullNameInputField.delegate = self
        phoneNumberInputField.delegate = self
        profilePictureHelper.delegate = self
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        //set font of segmented control
        let font=UIFont.systemFont(ofSize: 8)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        
        setPopUpButton()
        
        secondSignUpHelper.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Put the current user's info to the screen
        profilePictureHelper.getImageDataFromFireStorage(urlString: User.sharedInstance.profilePictureUrl)
        secondSignUpHelper.setFieldsOfInputsAsCurrentProfile()
    }
    
    
    @IBAction func checkBoxNoSmokingTapped(_ sender: UIButton) {
        if(noSmokingFlag==true){
            sender.setImage((UIImage(named:"uncheckedCheckbox")), for: .normal)
            noSmokingFlag=false
        }
        else{
            sender.setImage((UIImage(named:"checkedCheckbox")), for: .normal)
            noSmokingFlag=true
        }
    }
    
    
    @IBAction func checkBoxSilentRideTapped(_ sender: UIButton) {
        if(silentRideFlag==true){
            sender.setImage((UIImage(named:"uncheckedCheckbox")), for: .normal)
            silentRideFlag=false
        }
        else{
            sender.setImage((UIImage(named:"checkedCheckbox")), for: .normal)
            silentRideFlag=true
        }
    }
    
    @IBAction func uploadImageButtonTapped(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    
    @IBAction func saveTheChangesButtonTapped(_ sender: UIButton) {
        let segmentIndex = gradeSegmentedControl.selectedSegmentIndex
        if let fullName = fullNameInputField.text,
        let phoneNumber = phoneNumberInputField.text,
           let major = majorInputField.currentTitle{
            if fullName == "" || phoneNumber == ""{
                errorText.text = "Please enter all necessary information"
                errorText.isHidden = false
                errorText.textColor = UIColor.red
                errorText.adjustsFontSizeToFitWidth = true
            }
            else{
                // Save the changes in Firebase with a helper
                secondSignUpHelper.editUserData(fullName: fullName, phoneNumber: phoneNumber, major: major, segmentIndex: segmentIndex, noSmokingFlag: self.noSmokingFlag, silentRideFlag: self.silentRideFlag, userEmail: self.userEmail)
                
                // Also save the changes in the User class
                secondSignUpHelper.setUserInfo(fullName: fullName, phoneNumber: phoneNumber, major: major, segmentIndex: segmentIndex, noSmokingFlag: self.noSmokingFlag, silentRideFlag: self.silentRideFlag)
                self.navigationController?.popToRootViewController(animated: true)
            }

            
        }
        //Finally,
    }
    
    func setPopUpButton(){
        let optionClosure = {(action: UIAction) in
            print(action.title)}
        let defaultMenu = UIMenu(children: [
                UIAction(title: "International Relations", state: .on, handler: optionClosure),
                UIAction(title: "Economics", handler: optionClosure),
                UIAction(title: "Business Administration", handler: optionClosure),
                UIAction(title: "Chemical and Biological Engineering", handler: optionClosure),
                UIAction(title: "Computer Engineering", handler: optionClosure),
                UIAction(title: "Electrical and Electronics Engineering", handler: optionClosure),
                UIAction(title: "Industrial Engineering", handler: optionClosure),
                UIAction(title: "Mechanical Engineering", handler: optionClosure),
                UIAction(title: "Chemistry", handler: optionClosure),
                UIAction(title: "Physics", handler: optionClosure),
                UIAction(title: "Mathematics", handler: optionClosure),
                UIAction(title: "Molecular Biology and Genetics", handler: optionClosure),
                UIAction(title: "Archaeology and History of Art", handler: optionClosure),
                UIAction(title: "Comparative Literature", handler: optionClosure),
                UIAction(title: "History", handler: optionClosure),
                UIAction(title: "Psychology", handler: optionClosure),
                UIAction(title: "Philosophy", handler: optionClosure),
                UIAction(title: "Sociology", handler: optionClosure),
                UIAction(title: "Media and Visual Arts", handler: optionClosure),
                UIAction(title: "Law", handler: optionClosure),
                UIAction(title: "Medicine", handler: optionClosure),
                UIAction(title: "Nursing", handler: optionClosure),
            ])
        
        self.majorInputField.menu = defaultMenu
        self.majorInputField.showsMenuAsPrimaryAction=true
        self.majorInputField.changesSelectionAsPrimaryAction=true
        
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

extension EditProfileViewController: SecondSignUpDelegate{
    func setFieldsCurrentProfile(userEmail: String, fullName: String, phoneNumber: String, major: String, segmentIndex: Int, noSmokingFlag: Bool, silentRideFlag: Bool) {
        self.userEmail = userEmail
        self.fullNameInputField.text = fullName
        self.phoneNumberInputField.text = phoneNumber
        
        if let majorMenu = self.majorInputField.menu{
            self.majorInputField.menu =  secondSignUpHelper.setCurrentMajorAsChosen(actionTitle: major, menu: majorMenu)
        }
            
        
        self.gradeSegmentedControl.selectedSegmentIndex = segmentIndex
        
        
        self.noSmokingFlag = noSmokingFlag
        if(self.noSmokingFlag == true){
            self.checkBoxNoSmoking.setImage((UIImage(named:"checkedCheckbox")), for: .normal)
        }
        else{
            self.checkBoxNoSmoking.setImage((UIImage(named:"uncheckedCheckbox")), for: .normal)
        }
        
        self.silentRideFlag = silentRideFlag
        if(self.silentRideFlag == true){
            self.checkBoxSilentRide.setImage((UIImage(named:"checkedCheckbox")), for: .normal)
        }
        else{
            self.checkBoxSilentRide.setImage((UIImage(named:"uncheckedCheckbox")), for: .normal)
        }
    }
}


extension EditProfileViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension EditProfileViewController: ProfilePictureDelegate {
    func profileImageLoaded() {
        profilePictureImageView.image = UIImage(data: profilePictureHelper.imageData)
        self.profilePictureImageView.layer.borderWidth = 1.0
        self.profilePictureImageView.layer.masksToBounds = false
        self.profilePictureImageView.layer.borderColor = UIColor.white.cgColor
        self.profilePictureImageView.layer.cornerRadius = self.profilePictureImageView.frame.height / 2
        self.profilePictureImageView.clipsToBounds = true
    }

}

extension EditProfileViewController: UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profileImage = image
        } else{
            return
        }
        
        self.profilePictureImageView.image = self.profileImage
        self.profilePictureImageView.layer.borderWidth = 1.0
        self.profilePictureImageView.layer.masksToBounds = false
        self.profilePictureImageView.layer.borderColor = UIColor.white.cgColor
        self.profilePictureImageView.layer.cornerRadius = self.profilePictureImageView.frame.height / 2
        self.profilePictureImageView.clipsToBounds = true
        
        guard let imageData = profileImage.pngData() else {
            return
        }
        profilePictureHelper.setImageUrl(email: User.sharedInstance.getEmail(), imageData: imageData)
        
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }

}

extension EditProfileViewController: UINavigationControllerDelegate{
    
}
