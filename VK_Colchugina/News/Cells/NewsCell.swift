//
//  NewCell.swift
//  L2_Colchugina_Irina
//
//  Created by Ирина Кольчугина on 24.11.2020.
//

import UIKit

class NewsCell: UITableViewCell {

    
// MARK: - Outlets
    @IBOutlet weak var publicIconImageView: UIImageView!
    
    @IBOutlet weak var publicNameLable: UILabel!
    
    @IBOutlet weak var publicationDateLable: UILabel!
    @IBOutlet weak var newsTextLable: UILabel!
    
    @IBOutlet weak var newsIconImageView: UIImageView!
    @IBOutlet weak var shadowControl: ShadowOfFriendIconControl!
    
    @IBOutlet weak var feedbackControl: LikeControl!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
