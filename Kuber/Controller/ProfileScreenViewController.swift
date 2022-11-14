//
//  ProfileScreenViewController.swift
//  Kuber
//
//  Created by Arda Aliz on 31.10.2022.
//

import UIKit

class ProfileScreenViewController: UIViewController {
    
    let profileHelper = ProfileHelper()

    override func viewDidLoad() {
        super.viewDidLoad()

        profileHelper.delegate = self
    }
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var gradeLevelLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    


    @IBAction func editButton(_ sender: Any) {
    }

    
    @IBAction func historyOfRidesButton(_ sender: Any) {
    }
    
    @IBAction func historyOfHitchhikessButton(_ sender: Any) {
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
    func setUI() {
        
    }
    
    
}
