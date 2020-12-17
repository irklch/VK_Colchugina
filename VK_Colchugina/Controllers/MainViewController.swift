//
//  MainViewController.swift
//  L2_Colchugina_Irina
//
//  Created by Ирина Кольчугина on 29.11.2020.
//

import UIKit

class MainViewController: UIViewController {


    @IBOutlet weak var timeImageView: UIImageView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var singInButtomOutlet: UIButton!
    @IBOutlet weak var errorLable: UILabel!
    
        @IBAction func singInButton(_ sender: Any) {
            guard !passwordTextField.text!.isEmpty && !loginTextField.text!.isEmpty else {
                return errorLable.isHidden = false
            }
        errorLable.isHidden = true
        timeImageView.isHidden = false
        loginTextField.isHidden = true
        passwordTextField.isHidden = true
        helloLable.isHidden = true
        singInButtomOutlet.isHidden = true
        Session.shared.id = Int.random(in: 11111111...99999999)
        Session.shared.token = randomString(length: 10)
        UIView.transition(
            with: self.timeImageView,
            duration: 1,
            options: [.transitionCrossDissolve, .curveEaseInOut])
        {
            self.timeImageView.image =   UIImage(systemName: "hourglass")

        } completion: { comleted in
            UIView.transition(
                with: self.timeImageView,
                duration: 1,
                options: [.transitionCrossDissolve, .curveEaseInOut])
            {
                self.timeImageView.image = UIImage(systemName: "hourglass.tophalf.fill")
            } completion: { comleted in
                UIView.transition(
                    with: self.timeImageView,
                    duration: 1,
                    options: [.transitionFlipFromBottom, .curveEaseInOut],
                    animations: {
                        self.timeImageView.image = UIImage(systemName: "hourglass.bottomhalf.fill")
                    }, completion: nil)
            }
        }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.performSegue(withIdentifier: "tapBarController", sender: nil)
            }
    }
 
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    @IBOutlet weak var helloLable: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeImageView.isHidden = true
        errorLable.isHidden = true
        
    }
    
    var isTimeOn = false
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
            
            }
        
        
        
//        UIView.animate(withDuration: 3, delay: 1, options: [.autoreverse, .repeat, .curveEaseInOut], animations: {
//            self.timeImageView.frame.origin.x += 100
//        }, completion: nil)
        
//        UIView.transition(with: timeImageView, duration: 1, options: [.transitionCrossDissolve, .autoreverse, .repeat, .curveEaseInOut], animations: {
//            self.timeImageView.image = UIImage(systemName: "hourglass.tophalf.fill")
//        }, completion: {
//            completion in
//            self.timeImageView.image = UIImage(systemName: "hourglass")
//        })
    
        
        
       
        

    }


