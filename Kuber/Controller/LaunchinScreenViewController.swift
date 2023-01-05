//
//  LaunchinScreenViewController.swift
//  Kuber
//
//  Created by Begum Sen on 23.12.2022.
//

import UIKit

class LaunchinScreenViewController: UIViewController {
    
    @IBOutlet weak var iconImageView: UIImageView!
    let signInHelper = SignInHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInHelper.delegate = self
        let userDefault = UserDefaults.standard
        let userEmail = userDefault.string(forKey: "userEmail")
        let userPassword = userDefault.string(forKey: "userPassword")
        print("userEmail \(userEmail)")
        print("userPassword \(userPassword)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if let userEmail = userEmail, let userPassword = userPassword{
                print("userDefault")
                self.signInHelper.checkAndSignIn(userEmail: userEmail, userPassword: userPassword)
            } else {
                self.signInHelper.checkAndSignIn(userEmail: " ", userPassword: " ")
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        iconImageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.animation()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func animation (){
        UIView.animate(withDuration: 1){
            let size = self.view.frame.size.width * 1.5
            let xPosition = size - self.view.frame.width
            let yPosition = self.view.frame.height - size
            
            self.iconImageView.frame = CGRect(x: -(xPosition/2), y: (yPosition/2), width: size, height: size)
            self.iconImageView.alpha = 0
        }
    }
    
    
}

extension LaunchinScreenViewController: SignInDelegate {
    
    func signInTheUser() {
        // if the user's email and password is validated
        // the user will be signed in and navigated to home screen
        
        print("Begum signed in")
        if  let tabBar: UITabBarController = self.storyboard?.instantiateViewController(withIdentifier: "Tabbar") as? UITabBarController{
            //self.navigationController?.pushViewController(tabBar, animated: true)
            view?.window?.rootViewController = tabBar
        }
        self.navigationController?.setNavigationBarHidden(true, animated: true)
 
    }
    
    func giveSignInError( errorDescription: String) {
    }
    
    func doNotSignInTheUser(){
        if let signIn: UINavigationController = self.storyboard?.instantiateViewController(withIdentifier: "SignInNavigation") as? UINavigationController{
            view?.window?.rootViewController = signIn
        }
    }
}
