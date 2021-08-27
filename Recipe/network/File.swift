//
//  File.swift
//  Recipe
//
//  Created by Nouran Alaa on 24/08/2021.
//

import Foundation
import Alamofire
class NetworkManager {


    
    func fetchData(searchText : String , completionHandler : @escaping (Any)-> Void) {
            AF.request("https://api.edamam.com/api/recipes/v2?q=\(searchText)&app_id=e064ac44&app_key=850e0c72d1c141dd0c58bbf384e1b38e&type=public").validate().responseDecodable(of: SearchModel.self) { (response) in
                if let value = response.value{
                 completionHandler(value)
                 print(response.value?._links.next.href)
                 print(response.value?.hits[0].recipe.label)

                }
                }
    }
}






