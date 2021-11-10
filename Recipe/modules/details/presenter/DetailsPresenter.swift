//
//  DetailsPresenter.swift
//  Recipe
//
//  Created by Nouran Alaa on 12/09/2021.
//

import Foundation
class DetailsPresenter {
    
    weak var view : DetailsInput?
    init(view : DetailsInput ){
        self.view = view
    }
  
}
extension DetailsPresenter : DetailsOutput{
   
    func viewDidLoad() {
        view?.fillRecipeData()
        view?.handleImageGesture()
    }
    func didTapShare(){
        view?.showShareOptions()
    }
}
