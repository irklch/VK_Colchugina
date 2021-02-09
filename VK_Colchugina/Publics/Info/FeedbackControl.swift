//
//  FeedbackControl.swift
//  L2_Colchugina_Irina
//
//  Created by Ирина Кольчугина on 24.11.2020.
//

import UIKit

class FeedbackControl: UIControl {
    @IBOutlet var likeImageView: UIImageView!
    @IBOutlet var commentImageView: UIImageView!
    @IBOutlet var likesCountLable: UILabel!
    @IBOutlet var viewsImageView: UIImageView!
    @IBOutlet var viewsCountLable: UILabel!
    @IBOutlet var shareImageView: UIImageView!
    @IBInspectable var isToggled: Bool = false
    public var likesCount = Int.random(in: 1...100)
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewsCountLable.text = String(Int.random(in: 200...1000))
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        likesCountLable.text = String(likesCount)
        viewsImageView.tintColor = UIColor.black
        likeImageView.tintColor = UIColor.systemBlue
        
        if isToggled {
            likeImageView.tintColor = UIColor.red
            likesCountLable.text = String(likesCount + 1)
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
