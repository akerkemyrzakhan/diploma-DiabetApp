//
//  HomeViewController.swift
//  DiabetApp
//
//  Created by Мырзахан Акерке on 16.03.2021.
//

import UIKit
import Firebase


class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let Color = UIColor(red: 216/255.0, green: 217/255.0, blue: 255/255.0, alpha: 2.4)
        view.backgroundColor = Color
        if Auth.auth().currentUser != nil {
            let viewController = self.storyboard?.instantiateViewController(identifier: "tabBarVC") as! TabBarViewController
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .overFullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }
    


}
