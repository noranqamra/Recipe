//
//  DetailsProtocols.swift
//  Recipe
//
//  Created by Nouran Alaa on 12/09/2021.
//

import Foundation
protocol DetailsOutput {
    func viewDidLoad()
    func didTapShare()
}
protocol DetailsInput : class {
    func getSearchModel() -> SearchModel?
    func fillRecipeData()
    func showShareOptions ()
}
