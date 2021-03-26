//
//  SignUpViewController.swift
//  DiabetApp
//
//  Created by Мырзахан Акерке on 16.03.2021.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore




class SignUpViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var dateofbirthTextField: UITextField!
    
    @IBOutlet weak var typeTextField: UITextField!
    
    @IBOutlet weak var genderTextField: UITextField!
    
    @IBOutlet weak var carboTextField: UITextField!
    
    @IBOutlet weak var sugarTextField: UITextField!
    
    @IBOutlet weak var typeVers: UISegmentedControl!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var labelvalue: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    @IBAction func StepperChange(_ sender: UIStepper) {
        labelvalue.text = String(sender.value)
    }
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            typeTextField.text = "1"
        }
        else{
            typeTextField.text = "2"
        }
    }
   
    @IBAction func didChangeSegment2(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            genderTextField.text = "М"
        }
        else{
            genderTextField.text = "Ж"
        }
    }
    
    @IBAction func didChangeSedment3(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            sugarTextField.text = "ммоль/л"
        }
        else{
            sugarTextField.text = "мг/дл"
        }
    }
    
    func setUpElements(){
        errorLabel.alpha = 0
        Utilities.styleTextField(loginTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleTextField(dateofbirthTextField)
        Utilities.styleTextField(typeTextField)
        Utilities.styleTextField(genderTextField)
        Utilities.styleTextField(carboTextField)
        Utilities.styleTextField(sugarTextField)
        //Utilities.styleFilledButton(signUpButton)
        //Utilities.styleFilledButton(loginButton)
       
        
        
    }
    func isValidEmail(testStr:String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: testStr)
        }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }
   



    func validateFields() -> String? {
        if loginTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || dateofbirthTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || typeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || genderTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || sugarTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        let email = isValidEmail(testStr: emailTextField.text!)
        if email == false{
            return "This is not a valid email.Try again."
        }
        
        return nil
    }

    @IBAction func signUpTapped(_ sender: Any) {
        let error = validateFields()
        
        if error != nil {
            showAlert(title:"Error!!!", message: error!)
        }
        else{
            let username = loginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let birthdate = dateofbirthTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let type = typeTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let gender = genderTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let carbo = labelvalue.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let sugar = sugarTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            
            
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if  err != nil {
                    self.showAlert(title:"Error!!!",message:"Error creating user")
                }
                else{
                    let db = Firestore.firestore()
                    db.collection("patients").addDocument(data: ["username": username, "birthdate": birthdate, "type": type, "gender": gender, "carbo": carbo, "sugar": sugar, "uid": result!.user.uid ]) { (error) in
                        if error != nil {
                            self.showAlert(title:"Error",message:"Error saving user data")
                        }
                    }
                    self.transitionToHome()
            
        }
    }
    }
    }
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
        
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        let user = Auth.auth().currentUser
        user?.sendEmailVerification() { (error) in }
        
    }
    
    
}
