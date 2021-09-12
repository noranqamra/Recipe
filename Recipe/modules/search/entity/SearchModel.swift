//
//  SearchModel.swift
//  Recipe
//
//  Created by Nouran Alaa on 24/08/2021.
//

import Foundation
struct SearchModel : Decodable {
    var _links : LinksData
    var hits : [HitsData]
    var count : Int
}
struct LinksData : Decodable {
    var next : NextData
}
struct NextData : Decodable {
    var href : String
}
struct HitsData : Decodable {
    var recipe : RecipeData
}
struct RecipeData : Decodable{
    var label : String
    var image : String
    var source : String
    var healthLabels : [String]
    var ingredientLines : [String]
    var url : String
    var shareAs : String
}
