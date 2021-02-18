//
//  NewPublicsController.swift
//  L2_Colchugina_Irina
//
//  Created by Ирина Кольчугина on 11/8/20.
//

import UIKit

class NewPublicsController: UITableViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var newPublicsSearchBar: UISearchBar!
    let publicsService = PublicsSearchService()
    var publicsInfo = [PublicsSearchInfo]()
    var SearchActive: Bool {
        if newPublicsSearchBar.text == "" {
            return false
        } else {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newPublicsSearchBar.delegate = self
        publicsService.loadPublicsData(text: "я хочу") { [weak self] publics in
            for item in (0..<publics.count) {
                let newValue = PublicsSearchInfo()
                newValue.name = publics.name[item]
                print(newValue.name)
                newValue.photo = publics.photo[item]
                self!.publicsInfo.append(newValue)
            }
            self!.tableView.reloadData()
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if SearchActive {
//        return publicsInfo.count
//        }
//        else {
//            searchSome(text: "hellow")
            return publicsInfo.count
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewPublicCell", for: indexPath) as! NewPublicCell
        let publics = publicsInfo[indexPath.row]
        cell.nemeLable.text = publics.name
        let url = URL(string: publics.photo)
        cell.iconImageView.sd_setImage(with: url, completed: nil)
        return cell
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        searchSome(text: searchText)
//
//    }

}
