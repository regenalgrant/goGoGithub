//
//  RepoViewController.swift
//  goGoGithub
//
//  Created by Regenal Grant on 4/4/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {
    
    
    var allRepos = [Repository]() {
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
        super.viewDidLoad()
        // initialize nib file
        let repoNib = UINib(nibName: RepositoryCell.identifier, bundle: Bundle.main)
        // register nib to your tableview
        self.tableView.register(repoNib, forCellReuseIdentifier: RepositoryCell.identifier)
        
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
//        self.searchBar.delegate = self
        update()
    }
    
    func update() {
        print("update repo controller here!")
        GitHub.shared.getRepos {(repositories) in
            guard let repositories = repositories else { return }
            self.allRepos = repositories
            // print(repositories?.first)update tableview homework
        }
    }
    
}

extension RepoViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CustomTransition(duration: 1.0)
    }
    
    ///check/ask question override func prepare
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == RepoDetailViewController.identifier {
            segue.destination.transitioningDelegate = self
        }
    }
}

extension RepoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayRepos?.count ?? allRepos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.identifier, for: indexPath) as! RepositoryCell
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.performSegue(withIdentifier: RepoDetailViewController.identifier, sender: nil)
    }
}

////MARK:UISearchBar delegate
//extension RepoViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        
//        if let searchedText = searchBar.text {
//            self.displayRepos = self.allRepos.filter({$0.name.contains(searchedText)})
//            
//        }
//        
//        if searchBar.text == "" {
//            self.displayRepos = nil
//        }
//    }
//    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        self.displayRepos = nil
//        self.searchBar.resignFirstResponder()
//        
//    }
//    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        self.searchBar.resignFirstResponder()
//    }
//}
