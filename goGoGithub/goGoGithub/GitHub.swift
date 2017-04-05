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
typealias FetchReposCompletion = ([Repository]?) -> ()

enum GitHubAuthError : Error {
    case extractingCode
    
}

enum SaveOption {
    case userDefaults
}



class GitHub {
    
    private var session: URLSession
    private var components: URLComponents
    
    
    static let shared = GitHub()
    
    private init(){
        
        self.session = URLSession(configuration: .default)
        self.components =  URLComponents()
        
        self.components.scheme = "https"
        self.components.host = "api.github.com"
        if let token = UserDefaults.standard.getAccessToken() {
            let queryItem = URLQueryItem(name: "access_token", value: token)
            self.components.queryItems = [queryItem]
        }
    }
    
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
                            if let token = self.accessTokenFrom(dataString) {
                                if UserDefaults.standard.save(accessToken: token) {
                                    print("Saved to user default")
                                }
                            }
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
    
    func getRepos(completion: @escaping FetchReposCompletion) {
        
        if let token = UserDefaults.standard.getAccessToken() {
            let queryItem = URLQueryItem(name: "access_token", value: token)
            
            self.components.queryItems = [queryItem]
        }
        
        func returnToMain(results: [Repository]?){
            OperationQueue.main.addOperation {
                completion(results)
                
            }
        }
        
        self.components.path = "/user/repos"
        
        guard let url = self.components.url else { returnToMain(results: nil); return }
        
        self.session.dataTask(with: url) {(data, response, error) in
            
            if error != nil { returnToMain(results: nil); return }
            
            if let data = data {
                
                var repositories = [Repository]()
                
                do {
                    
                    if let rootJson = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)as? [[String : Any]] {
                        print(rootJson)
                        for repositoryJSON in rootJson{
                            if let repo = Repository(json: repositoryJSON) {
                                
                                repositories.append(repo)
                            }
                        }
                        returnToMain(results: repositories)
                    }
                    
                } catch {
                    
                }
                
            }
            
            }.resume()
        
    }
    
    func accessTokenFrom(_ string: String) -> String? {
        print(string)
        
        if string.contains("access_token") {
            let components = string.components(separatedBy: "&")
            for component in components {
                print(component)
                
                if component.contains("access_token") {
                    let token = component.components(separatedBy: "=").last
                    
                    return token
                }
            }
        }
        return nil
    }
}
