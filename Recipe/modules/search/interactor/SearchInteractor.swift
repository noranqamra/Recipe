//
//  SearchInteractor.swift
//  Recipe
//
//  Created by Nouran Alaa on 23/08/2021.
//

import Foundation
class SearchInteractor {
    private var network = NetworkManager()
    func fetchRecipeData (completionHandler : @escaping (Any)-> Void, searchKeyword: String , nextPageurl : String? , healthLabel : String? ){
        network.fetchData(healthLabel: healthLabel, searchText : searchKeyword, nextPageurl: nextPageurl , completionHandler: completionHandler)
    }
    
    
}
