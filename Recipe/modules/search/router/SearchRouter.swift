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
        let detailsStoryBoard = UIStoryboard(name: StoryBoardName.DETAILS.rawValue, bundle: nil)
        guard let detailsViewController = detailsStoryBoard.instantiateViewController(withIdentifier: ViewControllerIdentifier.DETAILS.rawValue) as? DetailsViewController else {return}
        detailsViewController.recipeData = recipeData
        guard let navigationController = UIApplication.topViewController()?.navigationController else{return}
        navigationController.pushViewController(detailsViewController, animated: true)
                
    }
}
