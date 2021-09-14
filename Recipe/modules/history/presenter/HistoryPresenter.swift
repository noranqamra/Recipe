//
//  HistoryPresenter.swift
//  Recipe
//
//  Created by Nouran Alaa on 05/09/2021.
//

import Foundation
class HistoryPresenter {
    
    weak var view : HistoryInput?
    init(view : HistoryInput ){
        self.view = view
    }
    
  
}
extension HistoryPresenter : HistoryOutput{
   
    func viewDidLoad() {
        view?.setViewControllerDelegates()
        view?.register()
    }
    func didSelectRowWith(text : String){
        view?.fillSearchBarWithText(text : text)
    }
}
