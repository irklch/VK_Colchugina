//
//  SortItemsOnSections.swift
//  VK_Colchugina
//
//  Created by Ирина Кольчугина on 06.02.2021.
//

import Foundation
func sortFriendOfSection (letters: [String], allFriendsInfo: [FriendsInfo]) -> [[FriendsInfo]] {
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
