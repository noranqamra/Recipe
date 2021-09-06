//
//  SearchPresenter.swift
//  Recipe
//
//  Created by Nouran Alaa on 23/08/2021.
//

import Foundation
class SearchPresenter {
    
    
    weak var view : SearchInput?
    var router : SearchRouter?
    var interactor : SearchInteractor?
    
    let set = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ ")

    init(view : SearchInput , router : SearchRouter, interactor : SearchInteractor){
        self.view = view
        self.router = router
    
        self.interactor = interactor
    }
    private func fetchRecipeData(){
        if ((view?.getSearchBarText() != "") && ((view?.getSearchBarText().rangeOfCharacter(from: set.inverted)) != nil)){
        interactor?.fetchRecipeData(completionHandler: { (value) in
            print((value as? SearchModel)?._links.next.href)
            if let response = value as? SearchModel{
                self.view?.setSearchModel(searchModel: response)}
        }, searchKeyword: (view?.getSearchBarText())!)
    
        
        }
    }
}
extension SearchPresenter : SearchOutput{
   
    func viewDidLoad() {
        
        view?.initRecipeArray()
        view?.setViewControllerDelegates()
        view?.cellNIBFile()
    }
    
    func didTapSearchTextField() {
        fetchRecipeData()
    }

}
