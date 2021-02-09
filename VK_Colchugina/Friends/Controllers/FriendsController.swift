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
    var friendsList = [FriendsInfo]()
    
    var searchActive: Bool {
        if friendsSearchBar.text == "" {
            return false
        }
        else {
            return true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapForHiddenKeybourd = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tapForHiddenKeybourd)
        
        friendsService.loadFriendsData { [weak self] friends in
            
            for item in (0..<friends.count) {
                if friends.firstName[item] != "DELETED" &&  friends.firstName[item] != "" {
                    let newValue = FriendsInfo()
                    newValue.firstName = friends.firstName[item]
                    newValue.lastName = friends.lastName[item]
                    newValue.photo = friends.photo[item]
                    newValue.id = friends.id[item]
                    self!.friendsList.append(newValue)
                }
            }
       
            self!.sectionName = sortLetters(allFriends: self!.friendsList)
            self!.friendsBySection = sortFriendOfSection(letters: self!.sectionName, allFriendsInfo: self!.friendsList)
            self!.friendsInSearch = self!.friendsList
            self?.tableView.reloadData()
            
            
        }
        
    }
   
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsSearchBar.delegate = self
        
       
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
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

//        self.performSegue(withIdentifier: "AboutFriendSegue", sender: nil)
        if segue.identifier == "AboutFriendSegue",
           let destinanionVC = segue.destination as? AnimatedFriendsPhotosController,
           let indexPath = tableView.indexPathForSelectedRow {

            if searchActive {
                friendsService.loadFriendsPhotos(id: friendsInSearch[indexPath.row].id) { [weak self] friendsPhoto in
                    photosForSegue = friendsPhoto
                    let friend = self!.friendsInSearch[indexPath.row]
                    destinanionVC.title = "\(friend.firstName) \(friend.lastName)"
//                    self!.performSegue(withIdentifier: "AboutFriendSegue", sender: nil)
                }

            }
            else {
                friendsService.loadFriendsPhotos(id: friendsInSearch[indexPath.row].id) { [weak self] friendsPhoto in
                    photosForSegue = friendsPhoto
                    let friend = self!.friendsBySection[indexPath.section][indexPath.row]
                    destinanionVC.title = "\(friend.firstName) \(friend.lastName)"
//                    self!.performSegue(withIdentifier: "AboutFriendSegue", sender: nil)
                }

            }

        }

    }
    
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
