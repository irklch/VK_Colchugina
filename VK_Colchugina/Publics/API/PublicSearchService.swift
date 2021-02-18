//
//  PublicResponse.swift
//  VK_Colchugina
//
//  Created by Ирина Кольчугина on 11.02.2021.
//

import Foundation
import Alamofire

class PublicsSearchInfo {
    var name = ""
    var photo = ""
}

class JsonPublicsSearchResponse: Decodable {
    let response: PublicsSearchResponse
}

class PublicsSearchResponse: Decodable {
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

class PublicsSearchService {
    func loadPublicsData(text: String, completion: @escaping (PublicsSearchResponse) -> Void ){
        let paramters: Parameters = [
                    "q": text,
            "type": "group",
                    "access_token": Session.shared.token!,
            "v": "5.126"
                ]

        //список друзей
        AF.request("https://api.vk.com/method/groups.search", parameters: paramters).responseData { response in
            do {
                let publics = try JSONDecoder().decode(JsonPublicsSearchResponse.self, from: response.value!)
                completion(publics.response)
            }
            catch {
                print("\(error)")
            }
        }
        
    }
}
