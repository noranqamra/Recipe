//
//  String+Extension.swift
//  Recipe
//
//  Created by Nouran Alaa on 14/09/2021.
//

import Foundation
import UIKit
extension String {
    func isAlphabet() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
            if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
                return false
                
            }
            else {
                return true
            }
        }
        catch {
            return false
        }
    }
}
