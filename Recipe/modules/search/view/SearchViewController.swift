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
    @IBOutlet weak var historyContainerView: UIView!
    @IBOutlet weak var filterContainerView: UIView!
    @IBOutlet weak var noSearchResult: UILabel!
    
    
    var presenter : SearchOutput?
    var searchModel : SearchModel?
    var interactor = SearchInteractor()
    var searchBarText: String?
    var isRequestingNextPage : Bool = false
    var currentFilter : Int = 0 {didSet{
        presenter?.didReceiveCurrentFilter(currentFilter: currentFilter)
        print(currentFilter)
    }}
    
    func addViewControllerAsChild(asChildViewController: UIViewController) {
        asChildViewController.view.frame = historyContainerView.bounds
        asChildViewController.view.frame = filterContainerView.bounds
        
        asChildViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        filterContainerView.addSubview(asChildViewController.view)
        asChildViewController.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPresenter()
        presenter?.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    // MARK: -
    private func initPresenter(){
        presenter = SearchPresenter(view: self, router : SearchRouter(), interactor: SearchInteractor())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchModel?.hits.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath ) as? SearchTableViewCell

        cell?.searchNameLabel.text = searchModel?.hits[indexPath.row].recipe.label
        let url = URL(string: searchModel?.hits[indexPath.row].recipe.image ??  "")
        cell?.searchImage.kf.setImage(with: url,options: [.cacheOriginalImage])
        cell?.searchSourceLabel.text = searchModel?.hits[indexPath.row].recipe.source
        cell?.searchHealthLabel.text = searchModel?.hits[indexPath.row].recipe.healthLabels.joined(separator: " - ")
        return cell ?? SearchTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let currentCount = searchModel?.hits.count , isRequestingNextPage == false{
            if indexPath.row == currentCount - 1 { // last cell
                if searchModel?.count ?? 0  > currentCount { // more items to fetch
                    presenter?.didRequestNextPage() // increment `fromIndex` by 20 before server call
                    isRequestingNextPage = true
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("recipe is selected")
        
        let detailsStoryBoard = UIStoryboard(name: "Details", bundle: nil)
        if let detailsViewController = detailsStoryBoard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController{
            let recipeData = searchModel?.hits[indexPath.row].recipe
            detailsViewController.recipeData = recipeData
            navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


extension SearchViewController : SearchInput{
    func showNoResult() {
        noSearchResult.isHidden = false
    }
    
    func hideNoResult() {
        noSearchResult.isHidden = true
    }
    
    func showResultTable() {
        resultTableView.isHidden = false
    }
    
    func hideResultTable() {
        resultTableView.isHidden = true

    }
    
    func resetSearchModel() {
        searchModel = nil
    }
    
    func reloadTableView() {
        resultTableView.reloadData()
    }
    
    func resetIsRequestingNextPage() {
        isRequestingNextPage = false
    }
    
    func getSearchModel() -> SearchModel? {
        return searchModel
    }
    
    
    func setViewControllerDelegates() {
        searchBar.delegate = self
        resultTableView.delegate = self
        resultTableView.dataSource = self
        historyContainerView.isHidden = true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {     //presenter
        searchBarText = searchBar.text
        print("searchTexter \(searchBarText)")
        historyContainerView.isHidden = true
        presenter?.didTapSearchTextField()
        UserDefaults.setUserSearch(key: searchBarText ?? "Error" )
        
        
        (children.first as? HistoryViewController)?.historyTableView.reloadData()
        
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        historyContainerView.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        historyContainerView.isHidden = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {  //presenter
        searchBar.showsCancelButton = false
        self.view.endEditing(true)
        historyContainerView.isHidden = true
    }
    
    func initRecipeArray() {
        
    }
    
    func showRecipe() {
        
    }
    
    func showError() {
        
    }
    
    func updateView() {
        
    }
    
    
    func showAvailableSuggestions() {
        
    }
    func getSearchBarText () -> String{
        return searchBarText ?? ""
    }
    func setSearchModel(searchModel : SearchModel){
        if let currentRecords = self.searchModel?.hits{
            self.searchModel?.hits = currentRecords + searchModel.hits
            self.searchModel?.count = searchModel.count
            self.searchModel?._links = searchModel._links
        }
        else{
            self.searchModel = searchModel
        }
        resultTableView.reloadData()
        self.view.endEditing(true)
    }
    func register (){
        let cellNib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        resultTableView.register(cellNib, forCellReuseIdentifier: "SearchTableViewCell")
    }
    
}




