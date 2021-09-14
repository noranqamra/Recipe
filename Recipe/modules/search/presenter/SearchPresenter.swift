//
//  SearchPresenter.swift
//  Recipe
//
//  Created by Nouran Alaa on 23/08/2021.
//

import Foundation
class SearchPresenter {
    
    
    private weak var view : SearchInput?
    private var router : SearchRouter?
    private var interactor : SearchInteractor?
    
    let set = CharacterSet(charactersIn: SearchStrings.CHARACTERS.rawValue)
    
    init(view : SearchInput , router : SearchRouter, interactor : SearchInteractor){
        self.view = view
        self.router = router
        
        self.interactor = interactor
    }
    private func fetchRecipeData(nextPageurl : String? , healthLabel : String? ){
        
        if ((view?.getSearchBarText() != GenericString.EMPTY.rawValue) && (view?.getSearchBarText() ?? GenericString.EMPTY.rawValue).isAlphabet() ){
            interactor?.fetchRecipeData(completionHandler: { (value) in
                self.handleFetchRecipeData(value: value)
                self.view?.resetIsRequestingNextPage()
            }, searchKeyword: (view?.getSearchBarText()) ?? GenericString.EMPTY.rawValue , nextPageurl: nextPageurl, healthLabel: healthLabel )
            
        }
       
    }
    private func handleFetchRecipeData (value : Any){
        if let response = value as? SearchModel{
            self.view?.setSearchModel(searchModel: response)
            self.view?.reloadTableView ()
            self.view?.setViewEndEditing()
            self.controlResultPreview (response : response)
        }
        else if let response = value as? Int , response == GenericNumbers.DEFAULT_INT_VALUE.rawValue{
            self.controlResultPreview (response: nil)
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
            healthLabelAPIKey = FilterAPIKey.LOW_SUGAR.rawValue
        }
        else if currentFilter == 2{
            healthLabelAPIKey = FilterAPIKey.KETO.rawValue
        }
        else if currentFilter == 3{
            healthLabelAPIKey = FilterAPIKey.VEGAN.rawValue
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
            view?.setIsRequestingNextPage()
        }
    }
    
}
