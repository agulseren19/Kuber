//
//  ProfileScreenViewController.swift
//  Kuber
//
//  Created by Arda Aliz on 31.10.2022.
//

import UIKit

class ProfileScreenViewController: UIViewController {
    
    let profileHelper = ProfileHelper()
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var gradeLevelLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    
    @IBOutlet weak var smokingCheckBoxImageView: UIImageView!
    
    @IBOutlet weak var chattinessCheckBoxImageView: UIImageView!
    


    
    @IBAction func historyOfRidesButton(_ sender: Any) {
    }
    
    @IBAction func historyOfHitchhikessButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileHelper.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileHelper.checkUserAndSetUI()
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

extension ProfileScreenViewController: ProfileDelegate{
    func makeProfileUIReady(user: User) {
        fullNameLabel.text = "\(user.fullName)"
        majorLabel.text = "\(user.major)"
        gradeLevelLabel.text = "\(user.classLevel)"
        phoneNumberLabel.text = "\(user.phoneNumber)"
        mailLabel.text = "\(user.email)"
        
        if user.smokingPreference {
            smokingCheckBoxImageView.image = UIImage(named: "checkedCheckbox")
        }else {
            smokingCheckBoxImageView.image = UIImage(named: "uncheckedCheckbox")
        }
        
        if user.chattinesFlag {
            chattinessCheckBoxImageView.image = UIImage(named: "uncheckedCheckbox")
        }else {
            chattinessCheckBoxImageView.image = UIImage(named: "checkedCheckbox")
        }

        
    }
    

    
}
