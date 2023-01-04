//
//  LaunchinScreenViewController.swift
//  Kuber
//
//  Created by Begum Sen on 23.12.2022.
//

import UIKit

class LaunchinScreenViewController: UIViewController {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.25) {
            self.performSegue(withIdentifier: "launchSegue", sender: self)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        iconImageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.animation()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func animation (){
        UIView.animate(withDuration: 1.5){
            let size = self.view.frame.size.width * 1.5
            let xPosition = size - self.view.frame.width
            let yPosition = self.view.frame.height - size
            
            self.iconImageView.frame = CGRect(x: -(xPosition/2), y: (yPosition/2), width: size, height: size)
            self.iconImageView.alpha = 0
        }
    }
    
    
}
