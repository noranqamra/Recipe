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
    private var presenter : FilterOutput?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPresenter()
        presenter?.viewDidLoad()
    }
    
    private func initPresenter(){
        presenter = FilterPresenter(view: self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FilterIntConstant.FILTERS_COUNT.rawValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.FILTER.rawValue, for: indexPath) as? FilterCell
        cell?.configure(indexPath: indexPath)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath)  {
        (parent as? SearchViewController)?.currentFilter = indexPath.row
    }
    
}
extension FilterViewController : FilterInput{
    func setViewControllerDelegates() {
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
    }
    
    func register() {
        let cellNib = UINib(nibName: CellIdentifier.FILTER.rawValue, bundle: nil)
        filterCollectionView.register(cellNib, forCellWithReuseIdentifier: CellIdentifier.FILTER.rawValue)
    }
    
    
}



