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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginButton.backgroundColor = UIColor.purple
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.addObserver(self, forKeyPath: "access_token", options: .new, context: nil)
        
    }

    @IBAction func printTokenPress(_ sender: Any) {

        
    }
    
    @IBAction func loginPress(_ sender: Any) {
        
        let parameters = ["scope" : "email,user"]
        
        GitHub.shared.oAuthRequestWith(parameters: parameters)
        
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "access_token")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "access_token" {
            OperationQueue.main.addOperation {
                self.loginButton.isEnabled = false
                self.loginButton.backgroundColor = UIColor.gray
            }
            let token = UserDefaults.standard.getAccessToken()
//            print("token")
            
            if token == nil {
                OperationQueue.main.addOperation {
                    self.loginButton.isEnabled = true
                    self.loginButton.backgroundColor = UIColor.purple
                }
            }
        }
    }
    
    deinit {
        UserDefaults.standard.removeObserver(self, forKeyPath: "access_token")
    }
}










