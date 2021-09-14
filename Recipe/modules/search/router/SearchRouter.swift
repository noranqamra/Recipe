//
//  SearchRouter.swift
//  Recipe
//
//  Created by Nouran Alaa on 23/08/2021.
//

import Foundation
import UIKit
class SearchRouter {
    func showDetails(recipeData : RecipeData){
        let detailsStoryBoard = UIStoryboard(name: "Details", bundle: nil)
        if let detailsViewController = detailsStoryBoard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController{
            detailsViewController.recipeData = recipeData
            if let navigationController = UIApplication.topViewController()?.navigationController{
                navigationController.pushViewController(detailsViewController, animated: true)
            }
        }
    }
}
