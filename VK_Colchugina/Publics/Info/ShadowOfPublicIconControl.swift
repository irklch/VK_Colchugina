//
//  ShadowOfPublicIconControl.swift
//  L2_Colchugina_Irina
//
//  Created by Ирина Кольчугина on 25.11.2020.
//

import UIKit

class ShadowOfPublicIconControl: UIControl {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.7
    }

}
