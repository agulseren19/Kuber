//
//  PublishRideViewController.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 3.11.2022.
//

import UIKit
import Foundation

class PublishRideViewController: UIViewController {


    @IBOutlet weak var fromLocation: UIButton!
    
    
    @IBOutlet weak var fromNeighbourhoodLocation: UIButton!
    
    @IBOutlet weak var toLocation: UIButton!
    
    @IBOutlet weak var toNeighbourhoodLocation: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    
    @IBOutlet weak var feeField: UITextField!
    
    @IBOutlet weak var numberOfSeatsField: UISegmentedControl!
    private let kuberDataSource=KuberDataSource()

    let publishRideHelper = PublishRideHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        publishRideHelper.delegate = self
        // Do any additional setup after loading the view.
        setFromLocationPopUpButton()
        setToLocationPopUpButton()
        setDefaultFromNeighbourhoodLocationPopUpButton()
        setDefaultToNeighbourhoodLocationPopUpButton()
        //feeField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
            fromLocation.setTitle("From (District)", for: .normal)
            fromNeighbourhoodLocation.setTitle("From (Neighbourhood)", for: .normal)
            toLocation.setTitle("To (District)", for: .normal)
            toNeighbourhoodLocation.setTitle("To (Neighbourhood)", for: .normal)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func publishButtonClicked(_ sender: UIButton) {
        let from = fromLocation.currentTitle!
        let to = toLocation.currentTitle!
        let fromNeighbourhood = fromNeighbourhoodLocation.currentTitle!
        let toNeighbourhood = toNeighbourhoodLocation.currentTitle!

        let date = datePicker.date
        let time = timePicker.date
        let fee = feeField.text!
        let numberOfSeats=numberOfSeatsField.selectedSegmentIndex+1
        publishRideHelper.saveRide(from: from, fromNeighbourhood: fromNeighbourhood, to: to,toNeighbourhood: toNeighbourhood, date: date, time: time, fee: fee, numberOfSeats: numberOfSeats)
    
    
}
    func setFromLocationPopUpButton(){
        let arraySize=kuberDataSource.getNumberDistricts()
        let iteration=arraySize-1
        let optionClosure = {(action: UIAction) in
            print(action.title)
            self.setFromNeighbourhoodLocationPopUpButton(title: action.title)

        }
        var children = Array<UIAction>(repeating: UIAction(title:"",handler: optionClosure), count: arraySize)
        for i in 0...iteration{
            print(i)
            if i == 0{
                print("inside")
                print(i)
                children[i]=UIAction(title: kuberDataSource.getDistrict(for: i)?.name ?? "", state: .on,handler: optionClosure)
            }
            else{
                children[i]=UIAction(title: kuberDataSource.getDistrict(for: i)?.name ?? "",handler: optionClosure)
            }
        }
        
        fromLocation.menu=UIMenu(children:children)
        fromLocation.showsMenuAsPrimaryAction=true
        fromLocation.changesSelectionAsPrimaryAction=true
        
        
    }
    func setToLocationPopUpButton(){
        let arraySize=kuberDataSource.getNumberDistricts()
        let iteration=arraySize-1
        let optionClosure = {(action: UIAction) in
            print(action.title)
            self.setToNeighbourhoodLocationPopUpButton(title: action.title)

        }
        var children = Array<UIAction>(repeating: UIAction(title:"",handler: optionClosure), count: arraySize)
        for i in 0...iteration{
            if i == 0{
                children[i]=UIAction(title: kuberDataSource.getDistrict(for: i)?.name ?? "", state: .on,handler: optionClosure)
            }
            else{
                children[i]=UIAction(title: kuberDataSource.getDistrict(for: i)?.name ?? "",handler: optionClosure)
            }
        }
        
        toLocation.menu=UIMenu(children:children)
        toLocation.showsMenuAsPrimaryAction=true
        toLocation.changesSelectionAsPrimaryAction=true
        
        
    }
    func setFromNeighbourhoodLocationPopUpButton(title:String){
        let number=kuberDataSource.getNumberOfNeighbourhood(with: title)
        let optionClosure = {(action: UIAction) in
            print(action.title) }
        var children = Array<UIAction>(repeating: UIAction(title:"",handler: optionClosure), count: number)
        for i in 0...number-1{
            if i == 0{
                children[i]=UIAction(title: kuberDataSource.getNeighbourhood(with: title , for: i) ?? "", state: .on,handler: optionClosure)
            }
            else{
                children[i]=UIAction(title: kuberDataSource.getNeighbourhood(with: title , for: i) ?? "",handler: optionClosure)
            }
        }
        
        fromNeighbourhoodLocation.menu=UIMenu(children:children)
        fromNeighbourhoodLocation.showsMenuAsPrimaryAction=true
        fromNeighbourhoodLocation.changesSelectionAsPrimaryAction=true
        
        
    }
    func setToNeighbourhoodLocationPopUpButton(title:String){
        let number=kuberDataSource.getNumberOfNeighbourhood(with: title)
        let optionClosure = {(action: UIAction) in
            print(action.title) }
        var children = Array<UIAction>(repeating: UIAction(title:"",handler: optionClosure), count: number)
        for i in 0...number-1{
            if i == 0{
                children[i]=UIAction(title: kuberDataSource.getNeighbourhood(with: title , for: i) ?? "", state: .on,handler: optionClosure)
            }
            else{
                children[i]=UIAction(title: kuberDataSource.getNeighbourhood(with: title , for: i) ?? "",handler: optionClosure)
            }
        }
        
        toNeighbourhoodLocation.menu=UIMenu(children:children)
        toNeighbourhoodLocation.showsMenuAsPrimaryAction=true
        toNeighbourhoodLocation.changesSelectionAsPrimaryAction=true
        
        
    }
    func setDefaultFromNeighbourhoodLocationPopUpButton(){
        let optionClosure = {(action: UIAction) in
            print(action.title)}
            self.fromNeighbourhoodLocation.menu=UIMenu(children: [
                UIAction(title: "From (Neighbourhood)", state: .on, handler: optionClosure),
            ])
            
            self.fromNeighbourhoodLocation.showsMenuAsPrimaryAction=true
            self.fromNeighbourhoodLocation.changesSelectionAsPrimaryAction=true
        
    }
    func setDefaultToNeighbourhoodLocationPopUpButton(){
        let optionClosure = {(action: UIAction) in
            print(action.title)}
            self.toNeighbourhoodLocation.menu=UIMenu(children: [
                UIAction(title: "To (Neighbourhood)", state: .on, handler: optionClosure),
            ])
            
            self.toNeighbourhoodLocation.showsMenuAsPrimaryAction=true
            self.toNeighbourhoodLocation.changesSelectionAsPrimaryAction=true
        
    }
}
extension PublishRideViewController: PublishRideDelegate {
    func publishedToDatabase(){
        print("aaaaaaaaa")
        self.navigationController?.popToRootViewController(animated: true)
        
    }
}

extension PublishRideViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
