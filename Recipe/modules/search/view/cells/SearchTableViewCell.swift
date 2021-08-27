//
//  SearchTableViewCell.swift
//  Recipe
//
//  Created by Nouran Alaa on 26/08/2021.
//

import UIKit

class SearchTableViewCell: UITableViewCell{
    @IBOutlet weak var searchNaameLabel: UILabel!
    @IBOutlet weak var searchSourceLabel: UILabel!
    @IBOutlet weak var searchHealthLabel: UILabel!

    
    @IBOutlet weak var searchImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
