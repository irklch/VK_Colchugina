//
//  AboutFriends_TableViewCell.swift
//  L2_Colchugina_Irina
//
//  Created by Ирина Кольчугина on 02.11.2020.
//

import UIKit

class FriendCell: UITableViewCell {
    
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
