//
//  Session.swift
//  L2_Colchugina_Irina
//
//  Created by Ирина Кольчугина on 17.12.2020.
//

import Foundation

class Session {
    static let shared = Session()
    
    private init() {}
    
    var token: String?
    var id: Int?
}
