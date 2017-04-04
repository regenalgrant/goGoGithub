//
//  RepoViewController.swift
//  goGoGithub
//
//  Created by Regenal Grant on 4/4/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        update()
    }
    func update() {
    print("update repo controller here!")
        GitHub.shared.getRepos {(repositories) in
            // print(repositories?.first)update tableview homework
        }
    }


}
