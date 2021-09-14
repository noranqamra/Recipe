//
//  SearchProtocols.swift
//  Recipe
//
//  Created by Nouran Alaa on 23/08/2021.
//

import Foundation

protocol SearchOutput {
    func viewDidLoad()
    func didTapSearchTextField()
    func didRequestNextPage()
    func didReceiveCurrentFilter(currentFilter : Int)
    func didSelectRowWith(recipeData : RecipeData)
}
protocol SearchInput : class {
    func showAvailableSuggestions()
    func showRecipe()
    func showError()
    func updateView()
    func initRecipeArray()
    func setViewControllerDelegates()
    func getSearchBarText () -> String
    func setSearchModel(searchModel : SearchModel)
    func getSearchModel() -> SearchModel?
    func register()
    func resetIsRequestingNextPage()
    func resetSearchModel()
    func reloadTableView()
    func showNoResult()
    func hideNoResult()
    func showResultTable()
    func hideResultTable()
    
}
