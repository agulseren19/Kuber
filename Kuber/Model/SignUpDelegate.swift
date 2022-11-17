//
//  SignUpDelegate.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 10.11.2022.
//

import Foundation
protocol SignUpDelegate {
    func signUpTheUser()
    func giveSignUpError(errorDescription: String)
}
