//
//  NoLibraryTableViewCell.swift
//  SampleAlamofire
//
//  Created by 佐藤瑠偉史 on 2021/10/27.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(item: GithubRepositoryModel) {
        repositoryNameLabel.text = item.fullName
        userNameLabel.text = item.owner.login
    }
    
}
