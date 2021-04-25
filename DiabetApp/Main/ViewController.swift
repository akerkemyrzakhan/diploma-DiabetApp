//
//  ViewController.swift
//  DiabetApp
//
//  Created by Мырзахан Акерке on 15.03.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard
        
        if defaults.bool(forKey: "isUserSignedIn") {
            let viewController = self.storyboard?.instantiateViewController(identifier: "welcomeViewID") as! UINavigationController
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .overFullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }

  
    
}

