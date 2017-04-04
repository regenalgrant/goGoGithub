//
//  Github.swift
//  goGoGithub
//
//  Created by Regenal Grant on 4/3/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import UIKit

//global constant "k" is constant//
let kOAuthBaseUrlString = "https://github.com/login/oauth/"

typealias GitHubOAuthCompletion = (Bool) -> ()

enum GitHubAuthError : Error {
    case extractingCode
    
}

enum SaveOption {
    case userDefaults
}



class GitHub {
    
    static let shared = GitHub()
    
    func oAuthRequestWith(parameters: [String: String]) {
        var parametersString = ""
        
        for (key, value) in parameters {
            parametersString += "&\(key)=\(value)"
        }
        
        print("Parameter String: \(parametersString)")
        
        //? denotes clients ID
        if let requestURL = URL(string: "\(kOAuthBaseUrlString)authorize?client_id=\(kGitHubClientID)\(parametersString)") {
            
            print(requestURL.absoluteString)
            
            UIApplication.shared.open(requestURL)
            
        }
    }
    private func getCodeFrom(url: URL) throws -> String {
        
        guard let code = url.absoluteString.components(separatedBy: "=").last else {
            throw GitHubAuthError.extractingCode
        }
        
        return code
    }
    
    func tokenRequestFor(url: URL, saveOptions : SaveOption, completion: @escaping  GitHubOAuthCompletion) {
        
        // function within a function, prevents you from rewriting this block//
        func complete(success: Bool) {
            OperationQueue.main.addOperation {
                completion(success)
            }
        }
        do {
            
            let code = try getCodeFrom(url: url)
            let requestString = "\(kOAuthBaseUrlString)access_token?client_id=\(kGitHubClientID)&client_secret=\(kGitHubClientSecret)&code=\(code)"
            
            if let requestURL = URL(string: requestString) {
                
                let session = URLSession(configuration: .default)
                
                session.dataTask(with: requestURL, completionHandler: { (data, response, error) in
                    
                    if error != nil {complete(success: false) }
                    
                    guard let data = data else { complete(success: false); return }
                    
                    if let dataString = String(data: data, encoding: .utf8){
                        if saveOptions == .userDefaults {
                            UserDefaults.standard.save(accessToken: dataString)
                        }
                        complete(success: true)
                    }
                }).resume() //common bug, tells data task to execute or resume//
                
            }
        } catch {
            print(error)
            complete(success: false)
        }
        
        
    }

}
