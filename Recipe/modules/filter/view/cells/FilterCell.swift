//
//  FilterCell.swift
//  Recipe
//
//  Created by Nouran Alaa on 07/09/2021.
//

import UIKit

class FilterCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure (indexPath : IndexPath) {
            self.textLabel?.text = UserDefaults.getUserSearch()[indexPath.row]
        }
    
}
