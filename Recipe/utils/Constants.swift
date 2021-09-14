//
//  Constants.swift
//  Recipe
//
//  Created by Nouran Alaa on 14/09/2021.
//

import Foundation
//MARK:- generic
enum ViewControllerIdentifier : String {
    case SEARCH = "SearchViewController"
    case HISTORY = "HistoryViewController"
    case FILTER = "FilterViewController"
    case DETAILS = "DetailsViewController"

}
enum StoryBoardName : String {
    case SEARCH = "Search"
    case HISTORY = "History"
    case FILTER = "Filter"
    case DETAILS = "Details"
}
enum CellIdentifier : String {
    case SEARCH = "SearchTableViewCell"
    case HISTORY = "HistoryCell"
    case FILTER = "FilterCell"
}
enum GenericString : String {
    case EMPTY = ""
    case NEW_LINE = "\n"
    case DASH = " - "
}
enum GenericNumbers : Int {
    case DEFAULT_INT_VALUE = 0
    case DECREMENTER = 1
    case MAX_SUGGESTIONS_COUNT = 10
    case ROW_HEIGHT = 100
}
//MARK:- search module
enum FilterAPIKey : String {
    case LOW_SUGAR = "low-sugar"
    case KETO = "keto-friendly"
    case VEGAN = "vegan"
}
enum SearchStrings : String {
    case CHARACTERS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ \n"
    case ERROR = "Error"
}
//MARK:- history module
enum HistoryStrings : String{
    case SEARCHED_DATA = "SEARCHED_DATA"
}
//MARK:- filter module
enum FilterIntConstant : Int {
    case FILTERS_COUNT = 4
}
enum FilterIndex : Int {
    case ALL = 0
    case LOW_SUGAR = 1
    case KETO = 2
    case VEGAN = 3
}
enum FilterCellName : String {
    case ALL = "All"
    case LOW_SUGAR = "Low Sugar"
    case KETO = "Keto"
    case VEGAN = "Vegan"
}
//MARK:- details module

