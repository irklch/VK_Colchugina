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
    var friendsItems: [[FriendsInfo]] = [[]]
    var friendsFromSearch: [FriendsInfo] = []
    let friendsService = FriendsService()
    var sectionName: [String] = []
    
    var searchActive: Bool {
        if friendsSearchBar.text!.isEmpty {
            return false
        }
        else {
            return true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var friendsList = [FriendsInfo]()
        
        friendsService.loadFriendsData { [weak self] friends in
            
            for item in (0..<friends.count) {
                if friends.firstName[item] != "DELETED" &&  friends.firstName[item] != "" {
                    let newValue = FriendsInfo()
                    newValue.firstName = friends.firstName[item]
                    newValue.lastName = friends.lastName[item]
                    newValue.photo = friends.photo[item]
                    newValue.id = friends.id[item]
                    friendsList.append(newValue)
                }
            }
       
            self!.sectionName = sortLetters(allFriends: friendsList)
            self!.friendsItems = sortFriendOfSection(letters: self!.sectionName, allFriendsInfo: friendsList)
            self!.friendsFromSearch = friendsList
            self!.tableView.reloadData()
           
        }
    }
   
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsSearchBar.delegate = self
        
        if searchActive {
            let tapForHiddenKeybourd = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
            view.addGestureRecognizer(tapForHiddenKeybourd)
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
            return friendsFromSearch.count
        }
        else {
            return friendsItems[section].count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendCell
        
        if searchActive {
            let friend = friendsFromSearch[indexPath.row]
            cell.nameLable.text = "\(friend.firstName) \(friend.lastName)"
            let url = URL(string: friend.photo)
            cell.iconImage.sd_setImage(with: url, completed: nil)
        }
        else {
            let friend = friendsItems[indexPath.section][indexPath.row]
            cell.nameLable.text = "\(friend.firstName) \(friend.lastName)"
            let url = URL(string: friend.photo)
            cell.iconImage.sd_setImage(with: url, completed: nil)

        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        if searchActive && !friendsFromSearch.isEmpty{

            return "Search friends"
        }
        else if searchActive && friendsFromSearch.isEmpty {
            return "NO RESULTS"
        }
        else {
            return sectionName[section]
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "FriendPhotoSegue",
           let destinanionVC = segue.destination as? AnimatedFriendsPhotosController,
           let indexPath = tableView.indexPathForSelectedRow {
            if searchActive {
                friendIdentifire = friendsFromSearch[indexPath.row].id
                    let friend = friendsFromSearch[indexPath.row]
                    destinanionVC.title = "\(friend.firstName) \(friend.lastName)"

            }
            else {
                friendIdentifire = friendsItems[indexPath.section][indexPath.row].id
                    let friend = friendsItems[indexPath.section][indexPath.row]
                    destinanionVC.title = "\(friend.firstName) \(friend.lastName)"

            }

        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        print(friendIdentifire, Session.shared.token)
    }
    
    
    //MARK: - SearchBar Configurations
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.setShowsCancelButton(true, animated: true)
        friendsFromSearch = []
        for sectionCount in (0..<sectionName.count){
        for item in friendsItems[sectionCount] {
            let itemString = "\(item.firstName) \(item.lastName)"
            if itemString.lowercased().contains(searchText.lowercased()) {
                friendsFromSearch.append(item)

            }

        }
       
        self.tableView.reloadData()
            
    }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        view.endEditing(true)
    }
}
