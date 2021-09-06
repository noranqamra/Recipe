//
//  SearchInteractor.swift
//  Recipe
//
//  Created by Nouran Alaa on 23/08/2021.
//

import Foundation
class SearchInteractor {
    var network = NetworkManager()
    func fetchRecipeData (completionHandler : @escaping (Any)-> Void, searchKeyword: String){
        print(searchKeyword)
//        UserDefaults.setUserSearch(key: searchKeyword)
        network.fetchData(searchText : searchKeyword, completionHandler: completionHandler)
    }
    
    
}
