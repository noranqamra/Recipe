//
//  FilterPresenter.swift
//  Recipe
//
//  Created by Nouran Alaa on 05/09/2021.
//

import Foundation
class FilterPresenter {
    
    private weak var view : FilterInput?
    init(view : FilterInput ){
        self.view = view
    }
  
}
extension FilterPresenter : FilterOutput{
   
    func viewDidLoad() {
        view?.setViewControllerDelegates()
        view?.register()
    }


}
