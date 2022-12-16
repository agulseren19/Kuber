//
//  SecondSignUpDelegate.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 17.11.2022.
//

import Foundation
protocol SecondSignUpDelegate {
    func makeFieldsEmpty()
    func setFieldsCurrentProfile(fullName: String, phoneNumber: String, smokingFlag: Bool, chattinessFlag: Bool)
}

extension SecondSignUpDelegate {
    func makeFieldsEmpty(){}
    func setFieldsCurrentProfile(fullName: String, phoneNumber: String, smokingFlag: Bool, chattinessFlag: Bool){}
}
