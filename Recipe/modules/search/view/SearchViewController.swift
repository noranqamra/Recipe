//
//  SearchViewController.swift
//  Recipe
//
//  Created by Nouran Alaa on 23/08/2021.
//

import UIKit
import Kingfisher
class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{


    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var historyTableView: UITableView!

    var recipeArray = [Recipe]()
    var presenter : SearchOutput?
    var searchModel : SearchModel?
    var interactor = SearchInteractor()
    var searchBarText: String?
    var history: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initPresenter()
        searchBar.delegate = self
        resultTableView.delegate = self
        resultTableView.dataSource = self
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.isHidden = true
        // Do any additional setup after loading the view.
    }


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {     //presenter
        searchBarText = searchBar.text
        print("searchTexter \(searchBarText)")
        historyTableView.isHidden = true
        presenter?.didTapSearchTextField()
        UserDefaults.setUserSearch(key: searchBarText ?? "Error" )
        history = UserDefaults.getUserSearch()
        historyTableView.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        historyTableView.isHidden = history.isEmpty
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        historyTableView.isHidden = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {  //presenter
        searchBar.showsCancelButton = false
        self.view.endEditing(true)
        historyTableView.isHidden = true
    }

    // MARK: -
    private func initPresenter(){
        presenter = SearchPresenter(view: self, router : SearchRouter(), interactor: SearchInteractor())
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == historyTableView {
            return history.count
        } else {
            return searchModel?.hits.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == historyTableView {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = history[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath ) as! SearchTableViewCell
            cell.searchNaameLabel.text = searchModel?.hits[indexPath.row].recipe.label
            let url = URL(string: searchModel?.hits[indexPath.row].recipe.image ??  "")
            cell.searchImage.kf.setImage(with: url,options: [.cacheOriginalImage])
            cell.searchSourceLabel.text = searchModel?.hits[indexPath.row].recipe.source
            cell.searchHealthLabel.text = searchModel?.hits[indexPath.row].recipe.healthLabels.joined(separator: " - ")
            return cell
        }
        
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == historyTableView {
            searchBar.text = history[indexPath.row]
            searchBarText = history[indexPath.row]
            historyTableView.isHidden = true
            presenter?.didTapSearchTextField()
        }
    }


}
struct Recipe{
    let title : String
    let source : String
    let health : String

}

extension SearchViewController : SearchInput{
    func showRecipe() {

    }

    func showError() {

    }

    func updateView() {

    }

    func initRecipeArray() {
        recipeArray.append(Recipe(title : "Title" , source : "Source" , health : "Health Labels"))
        recipeArray.append(Recipe(title : "Title" , source : "Source" , health : "Health Labels"))
        recipeArray.append(Recipe(title : "Title" , source : "Source" , health : "Health Labels"))
        recipeArray.append(Recipe(title : "Title" , source : "Source" , health : "Health Labels"))
        recipeArray.append(Recipe(title : "Title" , source : "Source" , health : "Health Labels"))

    }

    func showAvailableSuggestions() {

    }
    func getSearchBarText () -> String{
        return searchBarText ?? ""
    }
    func setSearchModel(searchModel : SearchModel){
        self.searchModel = searchModel
      //  history = UserDefaults.standard.getUserSearch()
        resultTableView.reloadData()
//        historyTableView.reloadData()
        self.view.endEditing(true)
    }

}
extension UserDefaults {
   static func setUserSearch(key: String) {
        var array = getUserSearch()
        if !array.contains(key) {
            array.append(key)
        }
        if array.count > 10 { array.removeFirst() }
        UserDefaults.standard.set(array, forKey: "SEARCHED_DATA")
        
    }
    static func getUserSearch() -> [String] {
        guard let array = UserDefaults.standard.object(forKey: "SEARCHED_DATA") as? [String] else { return [] }
        return array
    }
}


 

