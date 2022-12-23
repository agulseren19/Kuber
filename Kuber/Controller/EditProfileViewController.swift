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
    @IBOutlet weak var checkBoxChattiness: UIButton!
    @IBOutlet weak var checkBoxSmoking: UIButton!
    @IBOutlet weak var majorInputField: UIButton!
    
    // Initialization values
    private var smokingFlag: Bool = true
    private var chattinessFlag: Bool = true
    var userEmail: String = ""
    
    //I am using the SecondSignUPHelper class because the reasoning behind creating profile and editing it is same.
    let secondSignUpHelper = SecondSignUpHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        fullNameInputField.delegate = self
        phoneNumberInputField.delegate = self
        
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        //set font of segmented control
        let font=UIFont.systemFont(ofSize: 8)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        
        setPopUpButton()
        
        secondSignUpHelper.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Put the current user's info to the screen
        secondSignUpHelper.setFieldsOfInputsAsCurrentProfile()
    }
    
    
    @IBAction func checkBoxSmokingTapped(_ sender: UIButton) {
        if(smokingFlag==true){
            sender.setImage((UIImage(named:"uncheckedCheckbox")), for: .normal)
            smokingFlag=false
        }
        else{
            sender.setImage((UIImage(named:"checkedCheckbox")), for: .normal)
            smokingFlag=true
        }
    }
    
    
    @IBAction func checkBoxChattinessTapped(_ sender: UIButton) {
        if(chattinessFlag==true){
            sender.setImage((UIImage(named:"uncheckedCheckbox")), for: .normal)
            chattinessFlag=false
        }
        else{
            sender.setImage((UIImage(named:"checkedCheckbox")), for: .normal)
            chattinessFlag=true
        }
    }
    
    
    
    @IBAction func saveTheChangesButtonTapped(_ sender: UIButton) {
        let fullName = fullNameInputField.text!
        let phoneNumber = phoneNumberInputField.text!
        let major = majorInputField.currentTitle!
        let segmentIndex = gradeSegmentedControl.selectedSegmentIndex
        
        // Save the changes in Firebase with a helper
        secondSignUpHelper.signUp(fullName: fullName, phoneNumber: phoneNumber, major: major, segmentIndex: segmentIndex, smokingFlag: self.smokingFlag, chattinessFlag: self.chattinessFlag, userEmail: self.userEmail)
        
        // Also save the changes in the User class
        secondSignUpHelper.setUserInfo(fullName: fullName, phoneNumber: phoneNumber, major: major, segmentIndex: segmentIndex, smokingFlag: self.smokingFlag, chattinessFlag: self.chattinessFlag)
        
        //Finally,
        self.navigationController?.popToRootViewController(animated: true)
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
    func setFieldsCurrentProfile(userEmail: String, fullName: String, phoneNumber: String, major: String, segmentIndex: Int, smokingFlag: Bool, chattinessFlag: Bool) {
        self.userEmail = userEmail
        self.fullNameInputField.text = fullName
        self.phoneNumberInputField.text = phoneNumber
        
        if let majorMenu = self.majorInputField.menu{
            self.majorInputField.menu =  secondSignUpHelper.setCurrentMajorAsChosen(actionTitle: major, menu: majorMenu)
        }
            
        
        self.gradeSegmentedControl.selectedSegmentIndex = segmentIndex
        
        
        self.smokingFlag = smokingFlag
        if(self.smokingFlag == true){
            self.checkBoxSmoking.setImage((UIImage(named:"checkedCheckbox")), for: .normal)
        }
        else{
            self.checkBoxSmoking.setImage((UIImage(named:"uncheckedCheckbox")), for: .normal)
        }
        
        self.chattinessFlag = chattinessFlag
        if(self.chattinessFlag == true){
            self.checkBoxChattiness.setImage((UIImage(named:"checkedCheckbox")), for: .normal)
        }
        else{
            self.checkBoxChattiness.setImage((UIImage(named:"uncheckedCheckbox")), for: .normal)
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
