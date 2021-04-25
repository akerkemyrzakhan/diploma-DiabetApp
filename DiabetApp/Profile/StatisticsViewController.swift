//
//  StatisticsViewController.swift
//  DiabetApp
//
//  Created by Мырзахан Акерке 
//

import UIKit

class StatisticsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        
        let viewController = self.storyboard?.instantiateViewController(identifier: "profile") as! Profile
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overFullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    

}
