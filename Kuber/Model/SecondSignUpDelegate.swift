//
//  SecondSignUpDelegate.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 17.11.2022.
//

import Foundation
protocol SecondSignUpDelegate {
    func makeFieldsEmpty()
    func setFieldsCurrentProfile(userEmail: String, fullName: String, phoneNumber: String, major: String, segmentIndex: Int, smokingFlag: Bool, chattinessFlag: Bool)
}

extension SecondSignUpDelegate {
    func makeFieldsEmpty(){}
    func setFieldsCurrentProfile(userEmail: String, fullName: String, phoneNumber: String, major: String, segmentIndex: Int, smokingFlag: Bool, chattinessFlag: Bool){}
}
