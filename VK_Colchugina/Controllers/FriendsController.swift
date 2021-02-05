//
//  TableViewController_Friends.swift
//  L2_Colchugina_Irina
//
//  Created by Ирина Кольчугина on 01.11.2020.
//

import UIKit
import Alamofire
import SDWebImage

class FriendsController: UITableViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var friendsSearchBar: UISearchBar!

    var sectionName: [String] = []
    var friendsBySection: [[FriendsInfo]] = [[]]
    var friendsInSearch: [FriendsInfo] = []
    
    let friendsService = FriendsService()
    var freindsListFromResponse = FriendsResponse()
    var friendsList = [FriendsInfo]()
    
    
    var searchActive: Bool {
        if friendsSearchBar.text == "" {
            return false
        }
        else {
            return true
        }
    }
    
    
    // MARK: - Add letters for section header
    
    private func sortLetters(allFriends: [FriendsInfo]) -> [String] {
        var allLetters = [String]()
        for friends in allFriends {
            if !allLetters.contains("\(friends.firstName.first!)") {
                allLetters.append("\(friends.firstName.first!)")
            }
        }
        return allLetters.sorted()
    }
    
    
    //MARK: - Filter friends by sections
    
    private func sortFriendOfSection (letters: [String], allFriendsInfo: [FriendsInfo]) -> [[FriendsInfo]] {
        var i = 0
        var finishFriendsList = [[FriendsInfo]]()
        for letter in letters {
            finishFriendsList.append([])
            for item in allFriendsInfo {
                if letter == String(item.firstName.first!) {
                    
                    finishFriendsList[i].append(item)
                }
            }
            i += 1
        }
        return finishFriendsList
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
   
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsSearchBar.delegate = self
        let tapForHiddenKeybourd = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tapForHiddenKeybourd)
        
        friendsService.loadFriendsData { [weak self] friends in
            self?.freindsListFromResponse = friends
            
            for item in (0..<self!.freindsListFromResponse.count) {
                if self!.freindsListFromResponse.firstName[item] != "DELETED" &&  self!.freindsListFromResponse.firstName[item] != "" {
                    let newValue = FriendsInfo()
                    newValue.firstName = self!.freindsListFromResponse.firstName[item]
                    newValue.lastName = self!.freindsListFromResponse.lastName[item]
                    newValue.photo = self!.freindsListFromResponse.photo[item]
                    newValue.id = self!.freindsListFromResponse.id[item]
                    self!.friendsList.append(newValue)
                }
            }
            self!.sectionName = self!.sortLetters(allFriends: self!.friendsList)
            self!.friendsBySection = self!.sortFriendOfSection(letters: self!.sectionName, allFriendsInfo: self!.friendsList)
            self!.friendsInSearch = self!.friendsList
            self?.tableView.reloadData()
            
        }
    }
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if searchActive {
            return 1
        } else {
            return sectionName.count
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
         if searchActive {
            return friendsInSearch.count
        }
        else {
            return friendsBySection[section].count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendCell
        
        if searchActive {
            let friend = friendsInSearch[indexPath.row]
            cell.nameLable.text = "\(friend.firstName) \(friend.lastName)"
            let url = URL(string: friend.photo)
            cell.iconImage.sd_setImage(with: url, completed: nil)
        }
        else {
            let friend = friendsBySection[indexPath.section][indexPath.row]
            cell.nameLable.text = "\(friend.firstName) \(friend.lastName)"
            let url = URL(string: friend.photo)
            cell.iconImage.sd_setImage(with: url, completed: nil)

        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        if searchActive && !friendsInSearch.isEmpty{

            return "Search friends"
        }
        else if searchActive && friendsInSearch.isEmpty {
            return "NO RESULTS"
        }
        else {
            return sectionName[section]
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "AboutFriendSegue",
//           let destinanionVC = segue.destination as? AnimatedPhotosController,
//           let indexPath = tableView.indexPathForSelectedRow {
//            if searchActive {
//                destinanionVC.title = friendsInSearch[indexPath.row].first_name + " " +  friendsWhoAreInSomeSection[indexPath.section][indexPath.row].last_name
//                aboutIconForSegue = friendsInSearch[indexPath.row].photo
//            }
//            else {
//                destinanionVC.title = allFriendsInSections[indexPath.section][indexPath.row].name
//                aboutIconForSegue = allFriendsInSections[indexPath.section][indexPath.row].imageFile
//            }
//
//        }
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    //MARK: - SearchBar Configurations
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        friendsInSearch = []
        for item in friendsList {
            let itemString = "\(item.firstName) \(item.lastName)"
            if itemString.lowercased().contains(searchText.lowercased()) {
                friendsInSearch.append(item)
            }

        }
        self.tableView.reloadData()
    }

    
}
