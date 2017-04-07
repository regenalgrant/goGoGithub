//
//  RepoDetailViewController.swift
//  goGoGithub
//
//  Created by Regenal Grant on 4/5/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import UIKit
import SafariServices

class RepoDetailViewController: UIViewController {
    
    var repo : Repository!
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var starsLabel: UILabel!
    
    @IBOutlet weak var forkedLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = repo.name
        descriptionLabel.text = repo.description
        languageLabel.text = repo.language
        starsLabel.text = "Stars: \(repo.numOfStars)"
        forkedLabel.text = "forked: \(repo.isForked)"
        dateLabel.text = repo.createdDate
    }
    
    
    @IBAction func moreDetailPressed(_ sender: Any) {
        guard let repo = repo else { return }
        
//        presentWebViewControllerWith(urlString: repo.repoUrlString)
        presentSafariViewControllerWith(urlString: repo.repoUrlString)
        
    }
    
    func presentSafariViewControllerWith(urlString: String){
        
        guard let url = URL(string: urlString) else { return }
        
        let safariController = SFSafariViewController(url: url)
        self.present(safariController, animated: true, completion: nil)
        
    }

    
    @IBAction func donePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

