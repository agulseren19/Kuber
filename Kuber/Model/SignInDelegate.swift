//
//  SignInDelegate.swift
//  Kuber
//
//  Created by Begum Sen on 15.11.2022.
//

import Foundation

protocol SignInDelegate{
    func signInTheUser()
    func giveSignInError(errorDescription: String)
    func doNotSignInTheUser()
}
extension SignInDelegate {
    func doNotSignInTheUser(){}
}
