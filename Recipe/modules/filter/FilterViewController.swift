//
//  FilterViewController.swift
//  Recipe
//
//  Created by Nouran Alaa on 05/09/2021.
//

import Foundation
import UIKit

class FilterViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource {
    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    var presenter : FilterOutput?
    var all = "all"
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as? FilterCell
        cell?.configure(indexPath: indexPath)
        return cell ?? UICollectionViewCell()
    }
    
    
    
}
extension FilterViewController : FilterInput{
    func setViewControllerDelegates() {
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self 
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
