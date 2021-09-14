//
//  UserDefaults+Extension.swift
//  Recipe
//
//  Created by Nouran Alaa on 14/09/2021.
//

import Foundation
extension UserDefaults {
   static func setUserSearch(key: String) {
        var array = getUserSearch()
        if !array.contains(key) {
            array.append(key)
        }
    if array.count > GenericNumbers.MAX_SUGGESTIONS_COUNT.rawValue {
            array.removeFirst()
        }
    UserDefaults.standard.set(array, forKey: HistoryStrings.SEARCHED_DATA.rawValue )
    }
    static func getUserSearch() -> [String] {
        guard let array = UserDefaults.standard.object(forKey: HistoryStrings.SEARCHED_DATA.rawValue) as? [String] else { return [] }
        return array
    }
}
