//
//  LikeControl.swift
//  L2_Colchugina_Irina
//
//  Created by Ирина Кольчугина on 16.11.2020.
//

import UIKit

class LikeControl: UIControl {
    @IBOutlet var likesCountLable: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBInspectable var isToggled: Bool = false
    public let likeCount = Int.random(in: 1...100)
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
////
////        likeImageView.image = UIImage(named: "blackHeartForLike")!
////        likesCountLable.text = String(likeCount)
////
////        if isToggled {
////            likesCountLable.text = String(likeCount + 1)
////            likeImageView.image = UIImage(named: "redHeartForLike")!
////        }
//
//    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        likeImageView.image = UIImage(named: "blueHeartForLike")!
        likesCountLable.text = String(likeCount)

        if isToggled {
            likesCountLable.text = String(likeCount + 1)
            likeImageView.image = UIImage(named: "redHeartForLike")!
        }
        
       


    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGesture()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGesture()
    }
    
    private func setupGesture() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGR.numberOfTapsRequired = 2
        addGestureRecognizer(tapGR)
    }
    @objc private func tapped (_ swipeGesture: UIGestureRecognizer) {
        isToggled.toggle()
        
        setNeedsDisplay()
        
    }
}
