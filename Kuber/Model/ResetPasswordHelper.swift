//
//  ResetPasswordHelper.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 31.12.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class ResetPasswordHelper{
    var delegate: ResetPasswordDelegate?

    func checkAndSend (userEmail: String) {
        Auth.auth().sendPasswordReset(withEmail: userEmail) { error in
            if let error = error {
                var responseText: String = ""
                responseText = error.localizedDescription
                self.delegate?.giveSendError(errorDescription: responseText)
            }
            else{
                self.delegate?.sentNavigateBack()
            }
        }
    }


}

