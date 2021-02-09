//
//  ShadowOfIconControl.swift
//  L2_Colchugina_Irina
//
//  Created by Ирина Кольчугина on 16.11.2020.
//

import UIKit

class ShadowOfFriendIconControl: UIControl {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 7, height: 3)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.7
    }

}
