//
//  SortLettersOnSections.swift
//  VK_Colchugina
//
//  Created by Ирина Кольчугина on 06.02.2021.
//

import Foundation
func sortLetters(allFriends: [FriendsInfo]) -> [String] {
    var allLetters = [String]()
    for friends in allFriends {
        if !allLetters.contains("\(friends.firstName.first!)") {
            allLetters.append("\(friends.firstName.first!)")
        }
    }
    return allLetters.sorted()
}
