//
//  ResetViewController.swift
//  DiabetApp
//
//  Created by Мырзахан Акерке on 01.04.2021.
//

import UIKit
import Firebase

class ResetViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func backToProfile(_ sender: Any) {
        let profile2ViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? Profile2ViewController
        
        view.window?.rootViewController = profile2ViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func reset(_ sender: Any) {
        
        let auth = Auth.auth()
        
        auth.sendPasswordReset(withEmail: emailTextField.text!) { (error) in
            if let error = error {
                let alert = Service.createAlertController(title: "Error", message: error.localizedDescription)
                self.present(alert,animated: true,completion: nil)
                return
            }
            
            let alert = Service.createAlertController(title: "OK", message: "A password reset email has been sent!")
            self.present(alert,animated:true,completion: nil)
        }
    }
    
}
