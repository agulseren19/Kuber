//
//  LaunchScreenViewController.swift
//  Kuber
//
//  Created by Begum Sen on 23.12.2022.
//

import UIKit

class LaunchScreenViewController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.performSegue(withIdentifier: "launchSegue", sender: self)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        iconImageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.animation()
        }
    }
    
    func animation (){
        UIView.animate(withDuration: 1){
            let size = self.view.frame.size.width * 2
            let xPosition = size - self.view.frame.width
            let yPosition = self.view.frame.height - size
            
            self.iconImageView.frame = CGRect(x: -(xPosition/2), y: (yPosition/2), width: size, height: size)
            self.iconImageView.alpha = 0
        }
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
