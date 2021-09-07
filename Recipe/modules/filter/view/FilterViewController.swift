//
//  FilterViewController.swift
//  Recipe
//
//  Created by Nouran Alaa on 05/09/2021.
//

import Foundation
import UIKit

class FilterViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    var presenter : FilterOutput?
    var lowSugar = "low sugar"
    var keto = "keto"
    var vegan = "vegan"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPresenter()
        presenter?.viewDidLoad()
    }

private func initPresenter(){
    presenter = FilterPresenter(view: self)
}
}
extension FilterViewController : FilterInput{
    func setViewControllerDelegates() {
        filterCollectionView.delegate = self
    }
    
    func register() {
        let cellNib = UINib(nibName: "FilterCell", bundle: nil)
        filterCollectionView.register(cellNib, forCellWithReuseIdentifier: "FilterCell")
    }
    
    func collectionView(_ collectionView: UICollectionView,
      didSelectItemAt indexPath: IndexPath) -> Int {
        return indexPath.row + 1
      }
//    func selectingFilter() {
//        if  {
//            
//        }
//        else if  {
//            
//        }
//        else if  {
//            
//        }
//        else if  {
//            
//        }
//    }
//    func allSelected() {
//
//    }
//    func lowSugarSelected() {
//
//    }
//    func ketoSelected() {
//
//    }
//    func veganSelected() {
//
//    }


}
