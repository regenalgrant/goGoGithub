//
//  Repository.swift
//  goGoGithub
//
//  Created by Regenal Grant on 4/4/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import Foundation

class Repository {

    let name: String
    let createdDate: String
    let numOfStars: Int
    let isForked: Bool
    // could be nil
    let description: String?
    let language: String?
    let repoUrlString: String
    
    init?(json: [String: Any]){
        if let name = json["name"] as? String,
            let createdDate = json["created_at"] as? String,
            let numOfStars = json["stargazers_count"] as? Int,
            let isForked = json["fork"] as? Bool {
            
            self.name = name
            self.createdDate = createdDate
            self.numOfStars = numOfStars
            self.isForked = isForked
            self.repoUrlString = json["html_url"] as? String ?? "https://www.github.com"
            
            if let description = json["description"] as? String {
                self.description = description
            } else {
                self.description = "No description"
            }
            
            if let language = json["language"] as? String {
                self.language = language
            } else {
                self.language = "Undfined language"
            }
        } else {
            return nil
        }

    }
}



