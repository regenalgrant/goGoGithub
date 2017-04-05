//
//  RepoViewController.swift
//  goGoGithub
//
//  Created by Regenal Grant on 4/4/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {

    
    var allRepos = [Respository]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var displayRepos : [Repository]? {
        didSet {
            self.tableView.reloadData()
            
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewdDidLoad()
        
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        
        update()
    }

    func update() {
    print("update repo controller here!")
        GitHub.shared.getRepos {(repositories) in
            // print(repositories?.first)update tableview homework
        }
    }

}
