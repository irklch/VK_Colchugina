//
//  FriendsService.swift
//  VK_Colchugina
//
//  Created by Ирина Кольчугина on 23.01.2021.
//

import Foundation
import Alamofire
import SDWebImage

class FriendsInfo {
    var firstName = ""
    var lastName = ""
    var photo = ""
    var id = 0
}


class JsonFriendsResponse: Decodable {
    let response: FriendsResponse
}

class FriendsResponse: Decodable {
    var count = 0
    var firstName = [""]
    var lastName = [""]
    var photo = [""]
    var id = [0]
    
    private init () {
        
    }
    
    
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








class FriendsService {
    func loadFriendsData(completion: @escaping (FriendsResponse) -> Void ){
        
        //список друзей
        AF.request("https://api.vk.com/method/friends.get?order=name&fields=nickname,photo_200_orig&access_token=\(Session.shared.token!)&v=5.126").responseData { response in
            do {
                let friends = try JSONDecoder().decode(JsonFriendsResponse.self, from: response.value!)
//                print(Session.shared.token)
                completion(friends.response)
            }
            catch {
                print("\(error)")
            }
        }
        
    }
    
}




