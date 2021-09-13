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
    private func fetchRecipeData(nextPageurl : String? , healthLabel : String? ){
        
        if ((view?.getSearchBarText() != "") && isAlphabet(searchBarText: view?.getSearchBarText() ?? "" ) ){
            interactor?.fetchRecipeData(completionHandler: { (value) in
                print((value as? SearchModel)?._links.next.href)
                if let response = value as? SearchModel{
                    self.view?.setSearchModel(searchModel: response)
                }
                self.view?.resetIsRequestingNextPage()
            }, searchKeyword: (view?.getSearchBarText())!, nextPageurl: nextPageurl, healthLabel: healthLabel )
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
    func didReceiveCurrentFilter(currentFilter: Int) {
        view?.resetSearchModel()
        view?.reloadTableView()
        var healthLabelAPIKey : String?
        if currentFilter == 0{
            healthLabelAPIKey = nil
        }
        else if currentFilter == 1{
            healthLabelAPIKey = "low-sugar"
        }
        else if currentFilter == 2{
            healthLabelAPIKey = "keto-friendly"
        }
        else if currentFilter == 3{
            healthLabelAPIKey = "vegan"
        }
        fetchRecipeData(nextPageurl: nil, healthLabel: healthLabelAPIKey)
    }
    
    
    func viewDidLoad() {
        
        view?.initRecipeArray()
        view?.setViewControllerDelegates()
        view?.register()
    }
    
    func didTapSearchTextField() {
        fetchRecipeData(nextPageurl: nil, healthLabel: nil )
    }
    func didRequestNextPage(){
        if let nextPageurl = view?.getSearchModel()?._links.next.href{
            fetchRecipeData(nextPageurl: nextPageurl, healthLabel: nil )
        }
    }
    
}
