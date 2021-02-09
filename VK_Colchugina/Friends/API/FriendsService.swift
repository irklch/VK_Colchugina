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


class JsonPhotosResponse: Decodable {
    let response: PhotosResponse
}

class PhotosResponse: Decodable{
    var url = [""]
    enum CodingKeys: String, CodingKey {
        case count
        case items
    }
    enum ItemsKeys: String, CodingKey {
        case sizes
    }
    enum SizesKeys: String, CodingKey {
        case url
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let count = try values.decode(Int.self, forKey: .count)
        var itemsValues = try values.nestedUnkeyedContainer(forKey: .items)
        
        for _ in (0..<count) {
            let someItemsValues = try itemsValues.nestedContainer(keyedBy: ItemsKeys.self)
            var sizeValues = try someItemsValues.nestedUnkeyedContainer(forKey: .sizes)
            for _ in (0..<sizeValues.count!) {
                let someSizeValue = try sizeValues.nestedContainer(keyedBy: SizesKeys.self)
                self.url.append(try someSizeValue.decode(String.self, forKey: .url))
               
            }
            }
        }
    }





class FriendsService {
    func loadFriendsData(completion: @escaping (FriendsResponse) -> Void ){
        
        //список друзей
        AF.request("https://api.vk.com/method/friends.get?order=name&fields=nickname&fields=photo_200_orig&access_token=\(Session.shared.token!)&v=5.126").responseData { response in
            do {
                let friends = try JSONDecoder().decode(JsonFriendsResponse.self, from: response.value!)
                completion(friends.response)
            }
            catch {
                print("\(error)")
            }
        }
        
    }
    
    func loadFriendsPhotos(id: Int, completion: @escaping (PhotosResponse) -> Void )
    {
        AF.request("https://api.vk.com/method/photos.get?owner_id=\(id)&album_id=profile&access_token=\(Session.shared.token!)&v=5.126").responseData { (response) in
            do {
                let friendsPhoto = try JSONDecoder().decode(JsonPhotosResponse.self, from: response.value!)
                print("\(friendsPhoto.response)")
                completion(friendsPhoto.response)
            }
            catch {
                print("\(error)")
            }
        }
    }
}




