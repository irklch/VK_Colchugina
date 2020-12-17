//
//  AnimatedPhotosController.swift
//  L2_Colchugina_Irina
//
//  Created by Ирина Кольчугина on 11.12.2020.
//

import UIKit

class AnimatedPhotosController: UIViewController {
    
    @IBOutlet var photoImageView: UIImageView!
    
    @IBAction func backButton(_ sender: Any) {
        if photoIdentifire == 0 {
            photoIdentifire = aboutIconForSegue.count - 1
        }
        else {
            photoIdentifire = photoIdentifire - 1
        }
        UIView.animate(withDuration: 0.3) {[self] in
            self.photoImageView.transform = CGAffineTransform(translationX: -300, y: 0)
        } completion: { _ in
            self.photoImageView.image = aboutIconForSegue[self.photoIdentifire]
            self.photoImageView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 0.5,
                initialSpringVelocity: 0.2,
                options: .curveEaseInOut,
                animations: {
                    self.photoImageView.transform = .identity
                },
                completion: nil)
        }
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if photoIdentifire == aboutIconForSegue.count - 1 {
            photoIdentifire = 0
        }
        else {
            photoIdentifire = photoIdentifire + 1
        }
        UIView.animate(withDuration: 0.3) {[self] in
            self.photoImageView.transform = CGAffineTransform(translationX: 300, y: 0)
        } completion: { _ in
            self.photoImageView.image = aboutIconForSegue[self.photoIdentifire]
            self.photoImageView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 0.5,
                initialSpringVelocity: 0.2,
                options: .curveEaseInOut,
                animations: {
                    self.photoImageView.transform = .identity
                },
                completion: nil)
        }
        
    }
    private var photoIdentifire = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.image = aboutIconForSegue[photoIdentifire]
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(photoPan(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
        
        
        
    }
    
    @objc func photoPan (_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .changed:
            photoImageView.transform = CGAffineTransform(translationX: recognizer.translation(in: view).x, y: 0)
        case .ended:
            if recognizer.translation(in: view).x < 0 {
            
                if photoIdentifire == aboutIconForSegue.count - 1 {
                    photoIdentifire = 0
                }
                else {
                    photoIdentifire = photoIdentifire + 1
                }
                guard recognizer.translation(in: view).x < -70 else {
                    return UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                        self.photoImageView.transform = .identity
                    }, completion: nil)
                     
                }
                    UIView.animate(withDuration: 0.3) {[self] in
                        self.photoImageView.transform = CGAffineTransform(translationX: recognizer.translation(in: view).x - 300, y: 0)
                    } completion: { _ in
                        self.photoImageView.image = aboutIconForSegue[self.photoIdentifire]
                        self.photoImageView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
                        UIView.animate(
                            withDuration: 0.5,
                            delay: 0,
                            usingSpringWithDamping: 0.5,
                            initialSpringVelocity: 0.2,
                            options: .curveEaseInOut,
                            animations: {
                                self.photoImageView.transform = .identity
                            },
                            completion: nil)
                    }
                
            }
            else {
                if photoIdentifire == 0 {
                    photoIdentifire = aboutIconForSegue.count - 1
                }
                else {
                    photoIdentifire = photoIdentifire - 1
                }
                
                guard recognizer.translation(in: view).x > 70 else {
                    return UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                        self.photoImageView.transform = .identity
                    }, completion: nil)
                     
                }
                    UIView.animate(withDuration: 0.3) {[self] in
                        self.photoImageView.transform = CGAffineTransform(translationX: recognizer.translation(in: view).x + 300, y: 0)
                    } completion: { _ in
                        self.photoImageView.image = aboutIconForSegue[self.photoIdentifire]
                        self.photoImageView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
                        UIView.animate(
                            withDuration: 0.5,
                            delay: 0,
                            usingSpringWithDamping: 0.5,
                            initialSpringVelocity: 0.2,
                            options: .curveEaseInOut,
                            animations: {
                                self.photoImageView.transform = .identity
                            },
                            completion: nil)
                    }
                
            }
            
        default:
            break
        }
    }
    
}
