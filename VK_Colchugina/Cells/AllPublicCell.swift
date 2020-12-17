//
//  Public_TableViewCell.swift
//  L2_Colchugina_Irina
//
//  Created by Ирина Кольчугина on 02.11.2020.
//

import UIKit

class AllPublicCell: UITableViewCell {

    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    
  

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.iconImageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)

        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.2,
            options: .curveEaseInOut,
            animations: {
                self.iconImageView.transform = .identity


            },
            completion: nil)
        


    }
    
    
    
    
    
}
