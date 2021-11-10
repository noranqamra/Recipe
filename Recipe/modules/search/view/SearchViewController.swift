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
    
    
    private var presenter : SearchOutput?
    private var searchModel : SearchModel?
    private var interactor = SearchInteractor()
    private var searchBarText: String?
    private var isRequestingNextPage : Bool = false
    var currentFilter : Int = GenericNumbers.DEFAULT_INT_VALUE.rawValue {didSet{
        presenter?.didReceiveCurrentFilter(currentFilter: currentFilter)
    }}
    
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
        
        return searchModel?.hits.count ?? GenericNumbers.DEFAULT_INT_VALUE.rawValue
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.SEARCH.rawValue, for: indexPath ) as? SearchTableViewCell
        guard let recipeData = searchModel?.hits[indexPath.row].recipe else {return UITableViewCell()}
        cell?.configure(recipeData: recipeData)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let currentCount = searchModel?.hits.count , isRequestingNextPage == false , indexPath.row == currentCount - GenericNumbers.DECREMENTER.rawValue , searchModel?.count ?? GenericNumbers.DEFAULT_INT_VALUE.rawValue  > currentCount{
            presenter?.didRequestNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let searchData = searchModel?.hits[indexPath.row].recipe{
            presenter?.didSelectRowWith(recipeData: searchData)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(GenericNumbers.ROW_HEIGHT.rawValue)
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return text.isAlphabet()
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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {   
        searchBarText = searchBar.text
        historyContainerView.isHidden = true
        presenter?.didTapSearchTextField()
        UserDefaults.setUserSearch(key: searchBarText ?? SearchStrings.ERROR.rawValue )
        
        
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
        return searchBarText ?? GenericString.EMPTY.rawValue
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
    }

    func setViewEndEditing (){
        self.view.endEditing(true)

    }
    func setIsRequestingNextPage(){
        isRequestingNextPage = true
    }
    func register (){
        let cellNib = UINib(nibName: CellIdentifier.SEARCH.rawValue, bundle: nil)
        resultTableView.register(cellNib, forCellReuseIdentifier: CellIdentifier.SEARCH.rawValue)
    }
    
}




