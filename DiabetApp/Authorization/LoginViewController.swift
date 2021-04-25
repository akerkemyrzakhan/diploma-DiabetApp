//
//  LoginViewController.swift
//  DiabetApp
//
//  Created by Мырзахан Акерке on 16.03.2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    func setUpElements(){
        errorLabel.alpha = 0
        Utilities.styleTextField(loginTextField)
        Utilities.styleTextField(passwordTextField)
    }

 
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }

    @IBAction func loginTapped(_ sender: Any) {
        
        let email = loginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.showAlert(title: "Error!", message: error!.localizedDescription)
                
                
            }

            else {
                let viewController = self.storyboard?.instantiateViewController(identifier: "tabBarVC") as! TabBarViewController
                viewController.modalTransitionStyle = .crossDissolve
                self.navigationController?.pushViewController(viewController, animated: true)
                
            }
    }
    
}
}
