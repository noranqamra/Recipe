//
//  File.swift
//  Recipe
//
//  Created by Nouran Alaa on 24/08/2021.
//

import Foundation
import Alamofire
class NetworkManager {
    
    
    
    func fetchData(healthLabel : String? , searchText : String , nextPageurl : String? , completionHandler : @escaping (Any)-> Void) {
        var url = "https://api.edamam.com/api/recipes/v2?q=\(searchText)&app_id=e064ac44&app_key=850e0c72d1c141dd0c58bbf384e1b38e&type=public"
        if let nextPageurl = nextPageurl{
            url = nextPageurl
        }
        else if let healthLabel = healthLabel{
            url += "&health=\(healthLabel)"
        }
        AF.request(url).validate().responseDecodable(of: SearchModel.self) { (response) in
            if let value = response.value{
                completionHandler(value)
                
                
            }
            else{
                completionHandler(0)
            }
        }
    }
}






