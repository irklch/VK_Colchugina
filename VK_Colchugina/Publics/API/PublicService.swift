//
//  PublicResponse.swift
//  VK_Colchugina
//
//  Created by Ирина Кольчугина on 11.02.2021.
//

import Foundation
import Alamofire

class PublicsInfo {
    var name = ""
    var photo = ""
}

class JsonPublicsResponse: Decodable {
    let response: PublicsResponse
}

class PublicsResponse: Decodable {
    var count = 0
    var name = [""]
    var photo = [""]
    
    
    
    enum CodingKeys: String, CodingKey {
        case count
        case items
    }
    
    enum ItemsKeys: String, CodingKey {
        case name
        case photo = "photo_200"
        
    }
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try values.decode(Int.self, forKey: .count)
        
        var itemsValues = try values.nestedUnkeyedContainer(forKey: .items)
        for _ in (0..<count) {
            let firstItemValues = try itemsValues.nestedContainer(keyedBy: ItemsKeys.self)
            self.name.append(try firstItemValues.decode(String.self, forKey: .name))
            self.photo.append(try firstItemValues.decode(String.self, forKey: .photo))
        }
    }
}

class PublicsService {
    func loadPublicsData(completion: @escaping (PublicsResponse) -> Void ){
        
        //список друзей
        AF.request("https://api.vk.com/method/groups.get?extended=1&fields=name,photo_200&access_token=\(Session.shared.token!)&v=5.126").responseData { response in
            do {
                let publics = try JSONDecoder().decode(JsonPublicsResponse.self, from: response.value!)
                completion(publics.response)
            }
            catch {
                print("\(error)")
            }
        }
        
    }
}
