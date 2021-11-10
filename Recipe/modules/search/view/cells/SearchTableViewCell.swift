//
//  SearchTableViewCell.swift
//  Recipe
//
//  Created by Nouran Alaa on 30/08/2021.
//

import UIKit

class SearchTableViewCell: UITableViewCell {



    @IBOutlet weak var searchNameLabel: UILabel!
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
    func configure (recipeData : RecipeData) {
        self.searchNameLabel.text = recipeData.label
        let url = URL(string: recipeData.image ??  GenericString.EMPTY.rawValue)
        self.searchImage.kf.setImage(with: url,options: [.cacheOriginalImage])
        self.searchSourceLabel.text = recipeData.source
        self.searchHealthLabel.text = recipeData.healthLabels.joined(separator: GenericString.DASH.rawValue)
        }
    
}
