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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
