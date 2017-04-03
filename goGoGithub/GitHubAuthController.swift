//
//  GitHubAuthController.swift
//  goGoGithub
//
//  Created by Regenal Grant on 4/3/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import UIKit

class GitHubAuthController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func printTokenPress(_ sender: Any) {
        
    }
    
    @IBAction func loginPress(_ sender: Any) {
        
        let parameters = ["scope" : "email,user"]
        
        GitHub.shared.oAuthRequestWith(parameters: parameters)
        
    }
}










