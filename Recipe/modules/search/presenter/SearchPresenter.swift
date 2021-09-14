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
        
        if ((view?.getSearchBarText() != "") && (view?.getSearchBarText() ?? "").isAlphabet() ){
            interactor?.fetchRecipeData(completionHandler: { (value) in
                print((value as? SearchModel)?._links.next.href)
                if let response = value as? SearchModel{
                    self.view?.setSearchModel(searchModel: response)
                    self.controlResultPreview (response : response)
                }
                else if let response = value as? Int , response == 0{
                    self.controlResultPreview (response: nil)
                }
                self.view?.resetIsRequestingNextPage()
            }, searchKeyword: (view?.getSearchBarText())!, nextPageurl: nextPageurl, healthLabel: healthLabel )
            
        }
       
    }
    private func controlResultPreview (response : SearchModel?){
        if response?.hits.count ?? 0 > 0{
            view?.hideNoResult()
            view?.showResultTable()

        }
        else{
            view?.showNoResult()
            view?.hideResultTable()
        }
    }
    
    func didSelectRowWith(recipeData : RecipeData){
        router?.showDetails(recipeData : recipeData)
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
