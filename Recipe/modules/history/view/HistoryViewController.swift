//
//  HistoryViewController.swift
//  Recipe
//
//  Created by Nouran Alaa on 31/08/2021.
//

import UIKit

class HistoryViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var historyTableView: UITableView!
    
    var presenter : HistoryOutput?
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryCell
        cell?.configure(indexPath: indexPath )
        return cell ?? UITableViewCell()
        
        
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
extension UserDefaults {
   static func setUserSearch(key: String) {
        var array = getUserSearch()
        if !array.contains(key) {
            array.append(key)
        }
        if array.count > 10 {
            array.removeFirst()
        }
        UserDefaults.standard.set(array, forKey: "SEARCHED_DATA")
    }
    static func getUserSearch() -> [String] {
        guard let array = UserDefaults.standard.object(forKey: "SEARCHED_DATA") as? [String] else { return [] }
        return array
    }
}
extension HistoryViewController : HistoryInput{
    func setViewControllerDelegates() {
        historyTableView.delegate = self
        historyTableView.dataSource = self
    }
    
    func register() {
        
    }
    
    
}
