//
//  ViewController.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 25.10.2022.
//

import UIKit

class SecondSignUpViewController: UIViewController {
    
    @IBOutlet weak var fullNameInputField: UITextField!
    @IBOutlet weak var phoneNumberInputField: UITextField!
    
    @IBOutlet weak var majorInputField: UIButton!
    
    @IBOutlet weak var checkBoxNoSmoking: UIButton!
    
    @IBOutlet weak var checkboxSilentRide: UIButton!
    
    @IBOutlet weak var gradeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var errorText: UILabel!
    
    var noSmokingFlag=false
    var silentRideFlag=false
    let secondSignUpHelper = SecondSignUpHelper()
    
    var userEmail: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //set font of segmented control
        let font=UIFont.systemFont(ofSize: 8)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        secondSignUpHelper.delegate = self
        setPopUpButton()
        fullNameInputField.delegate = self
        phoneNumberInputField.delegate = self
    }
    
    
    
    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        let segmentIndex = gradeSegmentedControl.selectedSegmentIndex
        if let fullName = fullNameInputField.text
            ,let phoneNumber = phoneNumberInputField.text,
           let major = majorInputField.currentTitle{
            if fullName == "" || phoneNumber == ""{
                errorText.text = "Please enter all necessary information"
                errorText.isHidden = false
                errorText.textColor = UIColor.red
                errorText.adjustsFontSizeToFitWidth = true
            }
            else if phoneNumber.count != 13 || !phoneNumber.starts(with: "+90"){
                errorText.text = "Please enter phone number in correct format"
                errorText.isHidden = false
                errorText.textColor = UIColor.red
                errorText.adjustsFontSizeToFitWidth = true
            }
            else{
                secondSignUpHelper.signUp(fullName: fullName, phoneNumber: phoneNumber, major: major, segmentIndex: segmentIndex, noSmokingFlag: noSmokingFlag, silentRideFlag: silentRideFlag, userEmail: userEmail)
                if let navigationControllerUnwrapped = self.navigationController
                   {
                    let viewControllers: [UIViewController] = navigationControllerUnwrapped.viewControllers
                    for aViewController in viewControllers {
                        if aViewController is LogInViewController {
                            navigationControllerUnwrapped.popToViewController(aViewController, animated: true)
                        }
                    }
                }
            }
        }
        /*
         let db = Firestore.firestore()
         let docRef = db.collection("users").document(user.getEmail())
         docRef.getDocument { (document, error) in
         if let document = document, document.exists {
         print(document.get("password")!)
         } else {
         print("Document does not exist")
         }
         }*/
        //self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func noSmokingCheckBoxClicked(_ sender: UIButton) {
        if(noSmokingFlag==true){
            sender.setImage((UIImage(named:"uncheckedCheckbox")), for: .normal)
            noSmokingFlag=false
        }
        else{
            sender.setImage((UIImage(named:"checkedCheckbox")), for: .normal)
            noSmokingFlag=true
        }
    }
    
    @IBAction func silentRideCheckBoxClicked(_ sender: UIButton) {
        if(silentRideFlag==true){
            sender.setImage((UIImage(named:"uncheckedCheckbox")), for: .normal)
            silentRideFlag=false
        }
        else{
            sender.setImage((UIImage(named:"checkedCheckbox")), for: .normal)
            silentRideFlag=true
        }
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
    
}

extension SecondSignUpViewController: SecondSignUpDelegate {
    func makeFieldsEmpty(){
        fullNameInputField.text = ""
        phoneNumberInputField.text = ""
        majorInputField.setTitle("", for: .normal)
    }

}

extension SecondSignUpViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

