//
//  SearchProtocols.swift
//  Recipe
//
//  Created by Nouran Alaa on 23/08/2021.
//

import Foundation
// da be represent el presenter w 7atta feeh 7agat leha 3laqa bel lofecycle w user interactions
protocol SearchOutput {
    func viewDidLoad()
    
    func didTapSearchTextField()
    

}
// da be represent el view
protocol SearchInput : class {
    func showAvailableSuggestions()
    func showRecipe()
    func showError()
    func updateView()
    func initRecipeArray()
    func setViewControllerDelegates()
    func getSearchBarText () -> String
    func setSearchModel(searchModel : SearchModel)
    func cellNIBFile()
    
}
