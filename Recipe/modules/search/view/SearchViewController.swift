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
    

    var presenter : SearchOutput?
    var searchModel : SearchModel?
    var interactor = SearchInteractor()
    var searchBarText: String?

//    private lazy var historyViewController: HistoryViewController = {
//    // Load Storyboard
//    let storyboard = UIStoryboard(name: "History", bundle: Bundle.main)
//
//    // Instantiate View Controller
//    var viewController = storyboard.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
//
//    // Add View Controller as Child View Controller
//        self.addViewControllerAsChild(asChildViewController: viewController)
//
//    return viewController
//    }()
    
    
//    private lazy var filterViewController: FilterViewController = {
//    // Load Storyboard
//    let storyboard = UIStoryboard(name: "Filter", bundle: Bundle.main)
//
//    // Instantiate View Controller
//    var viewController = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
//
//    // Add View Controller as Child View Controller
//        self.addViewControllerAsChild(asChildViewController: viewController)
//
//    return viewController
//    }()

    
    
    private func remove(asChildViewController viewController: UIViewController) {
    // Notify Child View Controller
        viewController.willMove(toParent: nil)

    // Remove Child View From Superview
    viewController.view.removeFromSuperview()

    // Notify Child View Controller
        viewController.removeFromParent()
    }
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
//        historyAddContainer()
//        filterAddContainer()
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

            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath ) as! SearchTableViewCell
            cell.searchNameLabel.text = searchModel?.hits[indexPath.row].recipe.label
            let url = URL(string: searchModel?.hits[indexPath.row].recipe.image ??  "")
            cell.searchImage.kf.setImage(with: url,options: [.cacheOriginalImage])
            cell.searchSourceLabel.text = searchModel?.hits[indexPath.row].recipe.source
            cell.searchHealthLabel.text = searchModel?.hits[indexPath.row].recipe.healthLabels.joined(separator: " - ")
            return cell
        
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }


}


extension SearchViewController : SearchInput{
//    func historyAddContainer(){
//        addViewControllerAsChild(asChildViewController: historyViewController)
//    }
//    func filterAddContainer(){
//        addViewControllerAsChild(asChildViewController: filterViewController)
//    }
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
        self.searchModel = searchModel
        resultTableView.reloadData()
        self.view.endEditing(true)
    }
    func cellNIBFile (){
        let cellNib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        resultTableView.register(cellNib, forCellReuseIdentifier: "SearchTableViewCell")
    }

}


 

