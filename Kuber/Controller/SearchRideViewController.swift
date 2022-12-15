//
//  SearchRideViewController.swift
//  Kuber
//
//  Created by Begum Sen on 30.10.2022.
//

import UIKit

class SearchRideViewController: UIViewController {
    
    // @IBOutlet weak var toLocation: UITextField!
    //@IBOutlet weak var fromLocation: UITextField!
    
    @IBOutlet weak var fromLocation: UIButton!
    @IBOutlet weak var fromNeighbourhoodLocation: UIButton!
    @IBOutlet weak var toLocation: UIButton!
    @IBOutlet weak var toNeighbourhoodLocation: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var showAllSwitch: UISwitch!
    @IBOutlet weak var showAllLabel: UILabel!
    private let kuberDataSource=KuberDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showAllLabel.tag = 001
        //kuberDataSource.getListOfDistricts()
        setFromLocationPopUpButton()
        setToLocationPopUpButton()
        setDefaultFromNeighbourhoodLocationPopUpButton()
        setDefaultToNeighbourhoodLocationPopUpButton()

    }
    
    override func viewWillAppear(_ animated: Bool) {
            fromLocation.setTitle("From (District)", for: .normal)
            fromNeighbourhoodLocation.setTitle("From (Neighbourhood)", for: .normal)
            toLocation.setTitle("To (District)", for: .normal)
            toNeighbourhoodLocation.setTitle("To (Neighbourhood)", for: .normal)

    }
    
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        
    }
    
    func setFromLocationPopUpButton(){
        let number=kuberDataSource.getNumberDistricts()
        let optionClosure = {(action: UIAction) in
            print(action.title)
            self.setFromNeighbourhoodLocationPopUpButton(title: action.title)

        }
        var children = Array<UIAction>(repeating: UIAction(title:"",handler: optionClosure), count: number)
        for i in 0...number-1{
            if i == 0{
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
        let number=kuberDataSource.getNumberDistricts()
        let optionClosure = {(action: UIAction) in
            print(action.title)
            self.setToNeighbourhoodLocationPopUpButton(title: action.title)
        }
        var children = Array<UIAction>(repeating: UIAction(title:"",handler: optionClosure), count: number)
        for i in 0...number-1{
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
            print(action.title)
            
        }
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
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
         if let ridesViewController = segue.destination as? RidesViewController{
             let from = fromLocation.currentTitle!
             let fromNeighbourhood=fromNeighbourhoodLocation.currentTitle!
             let to = toLocation.currentTitle!
             let toNeighbourhood=toNeighbourhoodLocation.currentTitle!
             let date = datePicker.date
             let time = timePicker.date
             let all = showAllSwitch.isOn
             
             ridesViewController.from = fromNeighbourhood
             ridesViewController.fromNeighbourhood = fromNeighbourhood
             ridesViewController.to = toNeighbourhood
             ridesViewController.toNeighbourhood = toNeighbourhood
             ridesViewController.date = date
             ridesViewController.time = time
             ridesViewController.all = all
         }
     }
     
}







