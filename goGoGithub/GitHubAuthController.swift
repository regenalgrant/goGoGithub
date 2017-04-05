//
//  GitHubAuthController.swift
//  goGoGithub
//
//  Created by Regenal Grant on 4/3/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import UIKit

class GitHubAuthController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    
    func updateUI() {
        if let _ = UserDefaults.standard.getAccessToken() {
            loginButton.isEnabled = false
            
        } else {
            
            loginButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginButton.backgroundColor = UIColor.purple
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func printTokenPress(_ sender: Any) {

        
    }

    @IBAction func loginPress(_ sender: Any) {
        let parameters = ["scope" : "email,user,repo"]
        GitHub.shared.oAuthRequestWith(parameters: parameters)
        
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "access_token")
        updateUI()
    }
    
    
    
    func dismissAuthController(){
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
}











