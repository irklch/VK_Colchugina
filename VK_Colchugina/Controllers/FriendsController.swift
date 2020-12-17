//
//  TableViewController_Friends.swift
//  L2_Colchugina_Irina
//
//  Created by Ирина Кольчугина on 01.11.2020.
//

import UIKit

class FriendsController: UITableViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var friendsSearchBar: UISearchBar!
    let friendsList = [
        Friends(name: "Jameson Sam", imageFile: [UIImage(named: "Better than yesterday")!, UIImage(named: "Sam")!, UIImage(named: "Sam")!, UIImage(named: "Sam")!, UIImage(named: "Sam")!]),
        Friends(name: "Morgan Angela", imageFile: [UIImage(named: "Angela")!, UIImage(named: "Angela")!, UIImage(named: "Angela")!, UIImage(named: "Angela")!]),
        Friends(name: "Anderson Jane", imageFile: [UIImage(named: "Jane")!, UIImage(named: "Jane")!, UIImage(named: "Jane")!, UIImage(named: "Jane")!, UIImage(named: "Jane")!]),
        Friends(name: "Johnson Mike", imageFile: [UIImage(named: "Mike")!, UIImage(named: "Mike")!, UIImage(named: "Mike")!, UIImage(named: "Mike")!, UIImage(named: "Mike")!]),
        Friends(name: "Brown Smith", imageFile: [UIImage(named: "Smith")!, UIImage(named: "Smith")!, UIImage(named: "Smith")!, UIImage(named: "Smith")!, UIImage(named: "Smith")!]),
        Friends(name: "Moore Tom", imageFile: [UIImage(named: "Tom")!, UIImage(named: "Tom")!, UIImage(named: "Tom")!, UIImage(named: "Tom")!, UIImage(named: "Tom")!])
    ]
    var lettersOfSection: [String] = []
    var allFriendsInSections: [[Friends]] = []
    var filtredFriendsList: [Friends] = []
    var searchActive: Bool {
        if friendsSearchBar.text == "" {
            return false
        }
        else {
            return true
        }
    }
    
    
    // MARK: - Add letters for section header
    
    private func sortLetters(allFriends: [Friends]) -> [String] {
        var allLetters = [String]()
        for friends in friendsList {
            if !allLetters.contains(String(friends.name.first!)) {
                allLetters.append(String(friends.name.first!))
            }
        }
        return allLetters.sorted()
    }
    
    
    //MARK: - Filter friends by sections
    
    private func sortFriendOfSection (letters: [String], friends: [Friends]) -> [[Friends]] {
        var i = 0
        var finishFriendsList = [[Friends]]()
        for letter in letters {
            finishFriendsList.append([])
            for Friends in friends {
                if letter == String(Friends.name.first!) {
                    
                    finishFriendsList[i].append(Friends)
                }
            }
            i += 1
        }
        return finishFriendsList
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lettersOfSection = sortLetters(allFriends: friendsList)
        allFriendsInSections = sortFriendOfSection(letters: lettersOfSection, friends: friendsList)
        filtredFriendsList = friendsList
    }
    
    
    override func loadView() {
        super.loadView()
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsSearchBar.delegate = self
        print(Session.shared.id, Session.shared.token)
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if searchActive {
            return 1
        } else {
            return lettersOfSection.count
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filtredFriendsList.count
        }
        else {
            return allFriendsInSections[section].count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendCell
        
        if searchActive {
            cell.nameLable.text = filtredFriendsList[indexPath.row].name
            cell.iconImage.image = filtredFriendsList[indexPath.row].imageFile[0]
        }
        else {
            cell.nameLable.text = allFriendsInSections[indexPath.section][indexPath.row].name
            cell.iconImage.image = allFriendsInSections[indexPath.section][indexPath.row].imageFile[0]
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchActive && filtredFriendsList.count != 0{
            
            return "Search friends"
        }
        else if searchActive && filtredFriendsList.count == 0 {
            return "NO RESULTS"
        }
        else {
            return lettersOfSection[section]
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AboutFriendSegue",
           let destinanionVC = segue.destination as? AnimatedPhotosController,
           let indexPath = tableView.indexPathForSelectedRow {
            if searchActive {
                destinanionVC.title = filtredFriendsList[indexPath.row].name
                aboutIconForSegue = filtredFriendsList[indexPath.row].imageFile
            }
            else {
                destinanionVC.title = allFriendsInSections[indexPath.section][indexPath.row].name
                aboutIconForSegue = allFriendsInSections[indexPath.section][indexPath.row].imageFile
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    //MARK: - SearchBar Configurations
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtredFriendsList = []
        for item in friendsList {
            let itemString = String (item.name)
            if itemString.lowercased().contains(searchText.lowercased()) {
                filtredFriendsList.append(item)
            }
            
        }
        self.tableView.reloadData()
    }
    
    
}
