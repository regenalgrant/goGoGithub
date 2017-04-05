//
//  RepoDetailViewController.swift
//  goGoGithub
//
//  Created by Regenal Grant on 4/5/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import UIKit

class RepoDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
//Layout your TableViewCells as Nibs and create a subclass called RepositoryCell instead of using the Basic UITableViewCell.
//Your Nib should have UILabels for 3 pieces of data from the Repository:
//Repo Name
//Repo Description
//Repo Language
//Create RepoDetailViewController that will display Repository information.
//Implement the dismissal of the RepoDetailViewController.
//Your RepoDetailViewController should display at least these 6 pieces of data from the Repository:
//Repo Name
//Repo Description
//Programming Language
//Number Of Stars
//isFork: True or False
//createdAt: Date
//Create custom UIViewController Transition from HomeViewController to RepoDetailViewController.
