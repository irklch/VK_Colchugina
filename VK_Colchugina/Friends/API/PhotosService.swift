//
//  PhotosInfoFromApi.swift
//  VK_Colchugina
//
//  Created by Ирина Кольчугина on 11.02.2021.
//

import Foundation
import Alamofire

class JsonPhotosResponse: Decodable {
    let response: PhotosResponse
}

class PhotosResponse: Decodable{
    var photo = [""]
    enum CodingKeys: String, CodingKey {
        case count
        case items
    }
    enum ItemsKeys: String, CodingKey {
        case photo = "photo_604"
    }
    
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let count = try values.decode(Int.self, forKey: .count)
        var itemsValues = try values.nestedUnkeyedContainer(forKey: .items)
        
        for _ in (0..<count) {
            let someItemsValues = try itemsValues.nestedContainer(keyedBy: ItemsKeys.self)
            self.photo.append(try someItemsValues.decode(String.self, forKey: .photo))
            
        }
    }
}


class PhotosService {
    func loadFriendsPhotos(id: Int, completion: @escaping (PhotosResponse) -> Void )
    {
        AF.request("https://api.vk.com/method/photos.get?owner_id=\(id)&album_id=profile&access_token=\(Session.shared.token!)&v=5.21").responseData { (response) in
            do {
                let friendsPhoto = try JSONDecoder().decode(JsonPhotosResponse.self, from: response.value!)
                completion(friendsPhoto.response)
            }
            catch {
                print("\(error)")
            }
        }
    }
}
