//
//  ProfileHelper.swift
//  Kuber
//
//  Created by Arda Aliz on 14.11.2022.
//

import Foundation
class ProfileHelper{
    var delegate: ProfileDelegate?
    
    func checkUserAndSetUI(){
        let user = User.sharedInstance
        
        delegate?.makeProfileUIReady(user: user)
        
    }
}
