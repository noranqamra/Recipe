//
//  HistoryProtocols.swift
//  Recipe
//
//  Created by Nouran Alaa on 07/09/2021.
//

import Foundation
protocol HistoryOutput {
    func viewDidLoad()
    func didSelectRowWith(text : String)

}
protocol HistoryInput : class {
   
    func setViewControllerDelegates()
    func register()
    func fillSearchBarWithText(text : String)
    
}
