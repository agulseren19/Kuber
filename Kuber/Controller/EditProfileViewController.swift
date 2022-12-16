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
    
    private var smokingFlag = false
    private var chattinessFlag = false
    
    //I am using the SecondSignUPHelper class because the reasoning behind creating profile and editing it is same.
    let secondSignUpHelper = SecondSignUpHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EDIT PROFILE VIEW DID LOAD")

        // Do any additional setup after loading the view.
        
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        //set font of segmented control
        let font=UIFont.systemFont(ofSize: 8)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        
        secondSignUpHelper.delegate = self
        secondSignUpHelper.setFieldsOfInputsAsCurrentProfile()
        
        setPopUpButton()
        
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
        
        //Save the changes in the User class and Firebase with a helper
        
        
        //Finally,
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setPopUpButton(){
        let optionClosure = {(action: UIAction) in
            print(action.title)}
            self.majorInputField.menu=UIMenu(children: [
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
    func setFieldsCurrentProfile(fullName: String, phoneNumber: String, smokingFlag: Bool, chattinessFlag: Bool) {
        self.fullNameInputField.text = fullName
        self.phoneNumberInputField.text = phoneNumber
        self.smokingFlag = smokingFlag
        self.chattinessFlag = chattinessFlag
    }
}
