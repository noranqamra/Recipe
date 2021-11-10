//
//  FilterProtocols.swift
//  Recipe
//
//  Created by Nouran Alaa on 07/09/2021.
//

import Foundation
protocol FilterOutput {
    func viewDidLoad()
}
protocol FilterInput : class {
   
    func setViewControllerDelegates()
    func register()
    
}
