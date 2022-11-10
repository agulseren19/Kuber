//
//  SignUpHelper.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 10.11.2022.
//

import Foundation
class SignUpHelper{
    var delegate: SignUpDelegate?
    
    init() {
        setFirebaseSignUp()
    }
    func setFirebaseSignUp() {
        delegate?.setUI()
    }
    
}
