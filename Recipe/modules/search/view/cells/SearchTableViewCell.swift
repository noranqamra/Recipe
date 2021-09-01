//
//  SearchTableViewCell.swift
//  Recipe
//
//  Created by Nouran Alaa on 30/08/2021.
//

import UIKit

class SearchTableViewCell: UITableViewCell {


//    @IBOutlet weak var searchNaameLabel: UILabel!
//    @IBOutlet weak var searchSourceLabel: UILabel!
//    @IBOutlet weak var searchHealthLabel: UILabel!
//    @IBOutlet weak var searchImage: UIImageView!
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
    func configureCell (recipe : RecipeData?){
        if let recipe = recipe {
        self.searchNameLabel.text = recipe.label
        let url = URL(string: recipe.image ??  "")
        self.searchImage.kf.setImage(with: url,options: [.cacheOriginalImage])
        self.searchSourceLabel.text = recipe.source
        self.searchHealthLabel.text = recipe.healthLabels.joined(separator: " - ")
    }
    }
}
