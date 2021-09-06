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
    
    let set = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ \n")

    init(view : SearchInput , router : SearchRouter, interactor : SearchInteractor){
        self.view = view
        self.router = router
    
        self.interactor = interactor
    }
    private func fetchRecipeData(){
//        && ((view?.getSearchBarText().rangeOfCharacter(from: set.inverted)) != nil)
        
        if ((view?.getSearchBarText() != "") && isAlphabet(searchBarText: view?.getSearchBarText() ?? "" ) ){
        interactor?.fetchRecipeData(completionHandler: { (value) in
            print((value as? SearchModel)?._links.next.href)
            if let response = value as? SearchModel{
                self.view?.setSearchModel(searchModel: response)}
        }, searchKeyword: (view?.getSearchBarText())!)
    
        
        }
    }
    func isAlphabet(searchBarText : String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
            if regex.firstMatch(in: searchBarText, options: [], range: NSMakeRange(0, searchBarText.count)) != nil {
                 return false

            } else {
                return true
            }
        }
        catch {
            return false
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
