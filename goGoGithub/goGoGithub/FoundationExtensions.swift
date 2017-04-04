//
//  FoundationExtensions.swift
//  goGoGithub
//
//  Created by Regenal Grant on 4/3/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func getAccessToken()-> String? {
        guard let token = UserDefaults.standard.string(forKey: "access_token") else { return nil }
        return token
    }
    func save(accessToken: String) -> Bool {
        UserDefaults.standard.set(accessToken, forKey: "access_token")
        //save to return default//
        return UserDefaults.standard.synchronize()
        
    }
    
}
