//
//  SearchViewController.swift
//  Recipe
//
//  Created by Nouran Alaa on 23/08/2021.
//

import UIKit
import Kingfisher
class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchModel?.hits.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath ) as! SearchTableViewCell
        cell.searchNaameLabel.text = searchModel?.hits[indexPath.row].recipe.label
        let url = URL(string: searchModel?.hits[indexPath.row].recipe.image ??  "")
        cell.searchImage.kf.setImage(with: url,options: [.cacheOriginalImage])
        cell.searchSourceLabel.text = searchModel?.hits[indexPath.row].recipe.source
        cell.searchHealthLabel.text = searchModel?.hits[indexPath.row].recipe.healthLabels.joined(separator: " - ")
        return cell
    }
    

    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var tableView: UITableView!

    var recipeArray = [Recipe]()
    var presenter : SearchOutput?
    var searchModel : SearchModel?
    var interactor = SearchInteractor()
    var searchBarText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        initPresenter()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarText = searchBar.text
        print("searchTexter \(searchBarText)")
        presenter?.didTapSearchTextField()
        }

    // MARK: -
    private func initPresenter(){
        presenter = SearchPresenter(view: self, router : SearchRouter(), interactor: SearchInteractor())
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
        tableView.reloadData()
        print("$" , UserDefaults.standard.getUserSearch())
    }

}

 

