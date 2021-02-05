//
//  FriendsService.swift
//  VK_Colchugina
//
//  Created by Ирина Кольчугина on 23.01.2021.
//

import Foundation
import Alamofire

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
    let url = ""
    enum CodingKeys: String, CodingKey {
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
        var itemsValues = try values.nestedUnkeyedContainer(forKey: .items)
        let sizeValues = try itemsValues.nestedUnkeyedContainer(forKey: .size)
        let firstWeatherValues = try itemsValues.nestedContainer(keyedBy: ItemsKeys.self)


        

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
                print("!!!!!!!!!!!!!error              \(error)")
            }
        }
        
    }
    
    func loadFriendsPhotos(id: Int, completion: @escaping (FriendsResponse) -> Void )
    {
        AF.request("https://api.vk.com/method/photos.get?owner_id=\(id)&album_id=profile&access_token=\(Session.shared.token!)&v=5.126").responseJSON { (response) in
            do {
                let friends = try JSONDecoder().decode(JsonFriendsResponse.self, from: response.value!)
                completion(friends.response)
            }
            catch {
                print("!!!!!!!!!!!!!error              \(error)")
            }
        }
    }
}



