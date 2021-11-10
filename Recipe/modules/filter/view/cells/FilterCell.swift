//
//  FilterCell.swift
//  Recipe
//
//  Created by Nouran Alaa on 08/09/2021.
//

import UIKit

class FilterCell: UICollectionViewCell {

    @IBOutlet weak var filterNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure (indexPath : IndexPath) {
        
        if(indexPath.row == 0 ) {
            self.filterNameLabel.text = FilterCellName.ALL.rawValue
            }
        else if (indexPath.row == 1) {
            self.filterNameLabel.text = FilterCellName.LOW_SUGAR.rawValue
        }
        else if (indexPath.row == 2) {
            self.filterNameLabel.text = FilterCellName.KETO.rawValue
        }
        else if (indexPath.row == 3) {
            self.filterNameLabel.text = FilterCellName.VEGAN.rawValue
        }
    }
}

