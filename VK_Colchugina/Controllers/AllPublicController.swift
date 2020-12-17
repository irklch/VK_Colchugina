//
//  Public_TableViewController.swift
//  L2_Colchugina_Irina
//
//  Created by Ирина Кольчугина on 02.11.2020.
//

import UIKit

class AllPublicController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var publicsSearchBar: UISearchBar!
    var SearchActive: Bool {
        if publicsSearchBar.text == "" {
            return false
        } else {
            return true
        }
    }
    var filtredPublics: [Public] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        publicsSearchBar.delegate = self
        filtredPublics = allPublics
       
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if SearchActive {
            return filtredPublics.count
        }
        else {
            return allPublics.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllPublicCell", for: indexPath) as! AllPublicCell
        if SearchActive {
            cell.nameLable.text = filtredPublics[indexPath.row].name
            cell.iconImageView.image = filtredPublics[indexPath.row].icon
            return cell
        } else {
            cell.nameLable.text = allPublics[indexPath.row].name
            cell.iconImageView.image = allPublics[indexPath.row].icon
            return cell
        }
        
    }
    @IBAction func addNewPublicSegue(segue: UIStoryboardSegue){
        if let segueVC = segue.source as? NewPublicsController,
           let indexPath = segueVC.tableView.indexPathForSelectedRow {
            let newPublic = newPublics[indexPath.row]
            if !allPublics.contains(where: {$0.name == newPublic.name}) {
            allPublics.append(newPublic)
            tableView.reloadData()
            }
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            allPublics.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtredPublics = []
        for item in allPublics {
            let itemString = String (item.name)
            if itemString.lowercased().contains(searchText.lowercased()) {
                filtredPublics.append(item)
            }
            
        }
        self.tableView.reloadData()
    }
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.setSelected(true, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    
    
}
