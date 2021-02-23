//
//  FriendsService.swift
//  VK_Colchugina
//
//  Created by Ирина Кольчугина on 23.01.2021.
//

import Foundation
import Alamofire
import RealmSwift


class FriendsInfo {
    var firstName = ""
    var lastName = ""
    var photo = ""
    var id = 0
}


class JsonFriendsResponse: Decodable {
    let response: FriendsResponse
}

class FriendsResponse: Object, Decodable {
    @objc dynamic var count = 0
    @objc dynamic var firstName = [""]
    @objc dynamic var lastName = [""]
    @objc dynamic var photo = [""]
    @objc dynamic var id = [0]
    
    
    enum CodingKeys: String, CodingKey {
        case count
        case items
    }
    
    enum ItemsKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_200_orig"
        case id
        
    }
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try values.decode(Int.self, forKey: .count)
        
        var itemsValues = try values.nestedUnkeyedContainer(forKey: .items)
        for _ in (0..<count) {
            let firstItemValues = try itemsValues.nestedContainer(keyedBy: ItemsKeys.self)
            self.firstName.append(try firstItemValues.decode(String.self, forKey: .firstName))
            self.lastName.append(try firstItemValues.decode(String.self, forKey: .lastName))
            self.photo.append(try firstItemValues.decode(String.self, forKey: .photo))
            self.id.append(try firstItemValues.decode(Int.self, forKey: .id))
        }
    }
}



func saveFriendsData (_ friends: FriendsResponse) {
    do {
        let realm = try Realm()
        realm.beginWrite()
        realm.add(friends)
        try realm.commitWrite()
    } catch {
        print(error)
    }
}




class FriendsService {
    func loadFriendsData(completion: @escaping (FriendsResponse) -> Void ){
        
        //список друзей
        AF.request("https://api.vk.com/method/friends.get?order=name&fields=nickname,photo_200_orig&access_token=\(Session.shared.token!)&v=5.126").responseData { response in
            do {
                let friends = try JSONDecoder().decode(JsonFriendsResponse.self, from: response.value!)
                saveFriendsData(friends.response)
                completion(friends.response)
            }
            catch {
                print("\(error)")
            }
        }
        
    }
    
}




