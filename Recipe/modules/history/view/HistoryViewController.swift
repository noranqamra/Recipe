//
//  HistoryViewController.swift
//  Recipe
//
//  Created by Nouran Alaa on 31/08/2021.
//

import UIKit

class HistoryViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var historyTableView: UITableView!
    
    private var presenter : HistoryOutput?
    override func viewDidLoad() {
        super.viewDidLoad()
        initPresenter()
        presenter?.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    private func initPresenter(){
        presenter = HistoryPresenter(view: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefaults.getUserSearch().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.HISTORY.rawValue, for: indexPath) as? HistoryCell
        cell?.configure(indexPath: indexPath )
        return cell ?? UITableViewCell()
        
        
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowWith(text : UserDefaults.getUserSearch()[indexPath.row])

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(GenericNumbers.ROW_HEIGHT.rawValue)
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

extension HistoryViewController : HistoryInput{

    
    func setViewControllerDelegates() {
        historyTableView.delegate = self
        historyTableView.dataSource = self
    }
    
    func register() {
        let cellNib = UINib(nibName: CellIdentifier.HISTORY.rawValue, bundle: nil)
        historyTableView.register(cellNib, forCellReuseIdentifier: CellIdentifier.HISTORY.rawValue)
    }
    
    func fillSearchBarWithText(text : String){
        (parent as? SearchViewController)?.searchBar.text = text
    }

}
