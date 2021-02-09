//
//  IconController.swift
//  L2_Colchugina_Irina
//
//  Created by Ирина Кольчугина on 11/15/20.
//

import UIKit
class FriendsIconControl: UIControl {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.height/2
        layer.masksToBounds = true
    }
    
}
