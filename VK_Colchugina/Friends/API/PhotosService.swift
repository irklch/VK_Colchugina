//
//  PhotosInfoFromApi.swift
//  VK_Colchugina
//
//  Created by Ирина Кольчугина on 11.02.2021.
//

import Foundation

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
