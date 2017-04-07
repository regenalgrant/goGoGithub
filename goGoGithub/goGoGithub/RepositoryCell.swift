//
//  RepositoryCell.swift
//  goGoGithub
//
//  Created by Regenal Grant on 4/5/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {


    @IBOutlet weak var NameCell: UILabel!
    
    @IBOutlet weak var DescriptionCell: UILabel!
    
    @IBOutlet weak var LanguageCell: UILabel!
    
    var repo: Repository? {
        didSet {
            guard let repo = repo else { return }
            self.NameCell.text = repo.name
            self.DescriptionCell.text = repo.description
            self.LanguageCell.text = repo.language
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
