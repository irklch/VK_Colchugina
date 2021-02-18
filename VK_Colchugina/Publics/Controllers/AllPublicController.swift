//
//  Public_TableViewController.swift
//  L2_Colchugina_Irina
//
//  Created by Ирина Кольчугина on 02.11.2020.
//

import UIKit
import SDWebImage

class AllPublicController: UITableViewController, UISearchBarDelegate {
    
    let publicsService = PublicsService()
    var publicsInfo = [PublicsInfo]()
    var publicsFromSearch = [PublicsInfo]()
    @IBOutlet weak var publicsSearchBar: UISearchBar!
    var SearchActive: Bool {
        if publicsSearchBar.text == "" {
            return false
        } else {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        publicsSearchBar.delegate = self
        publicsFromSearch = publicsInfo
        publicsService.loadPublicsData { [weak self] publics in
            
            for item in (1..<publics.count) {
                let newValue = PublicsInfo()
                newValue.name = publics.name[item]
                print(newValue.name)
                newValue.photo = publics.photo[item]
                self!.publicsInfo.append(newValue)
                self!.tableView.reloadData()
            }
            
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if SearchActive {
            return publicsFromSearch.count
        }
        else {
            return publicsInfo.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllPublicCell", for: indexPath) as! AllPublicCell
        if SearchActive {
            let publics = publicsFromSearch[indexPath.row]
            cell.nameLable.text = publics.name
            let url = URL(string: publics.photo)
            cell.iconImageView.sd_setImage(with: url, completed: nil)
            return cell
        } else {
            let publics = publicsInfo[indexPath.row]
            cell.nameLable.text = publics.name
            let url = URL(string: publics.photo)
            cell.iconImageView.sd_setImage(with: url, completed: nil)
            return cell
        }
        
    }
//    @IBAction func addNewPublicSegue(segue: UIStoryboardSegue){
//        if let segueVC = segue.source as? NewPublicsController,
//           let indexPath = segueVC.tableView.indexPathForSelectedRow {
//            let newPublic = newPublics[indexPath.row]
//            if !publicsInfo.contains(where: {$0.name == newPublic.name}) {
//                publicsInfo.append(newPublic.name)
//                tableView.reloadData()
//            }
//        }
//    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            publicsInfo.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.setShowsCancelButton(true, animated: true)
        publicsFromSearch = []
        for item in publicsInfo {
            let itemString = String (item.name)
            if itemString.lowercased().contains(searchText.lowercased()) {
                publicsFromSearch.append(item)
            }
        }
        self.tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        view.endEditing(true)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.setSelected(true, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    
}
