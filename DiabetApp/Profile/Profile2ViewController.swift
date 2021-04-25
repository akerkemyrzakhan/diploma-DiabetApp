//
//  Profile2ViewController.swift
//  DiabetApp
//
//  Created by Мырзахан Акерке on 01.04.2021.
//

import UIKit
import Firebase
import FirebaseFirestore
import SwiftyJSON
class Profile2ViewController: UIViewController {

    var ref = Database.database().reference()

   
    @IBOutlet weak var usernameLbl: UITextField!
    
    @IBOutlet weak var mailLbl: UITextField!
    
    @IBOutlet weak var dateLbl: UITextField!
    
    @IBOutlet weak var type: UISegmentedControl!
    
    @IBOutlet weak var gender: UISegmentedControl!
    
    @IBOutlet weak var carbo: UILabel!
    
    @IBOutlet weak var sugar: UISegmentedControl!
    
    @IBOutlet weak var goalS: UITextField!
    
    @IBOutlet weak var HighS: UITextField!
    
    @IBOutlet weak var LowS: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = Firestore.firestore()
        let ref = db.collection("patients").document((Auth.auth().currentUser?.uid)!)
        ref.getDocument { (snapshot, err) in
            if let data = snapshot?.data() {
                self.usernameLbl.text = data["username"] as? String ?? ""
                //print(data["username"] ?? "")
                self.mailLbl.text = data["login"] as? String ?? ""
                self.dateLbl.text = data["birthdate"] as? String ?? ""
                let type = data["type"] as? String ?? ""
                if type == "1"{
                    self.type.selectedSegmentIndex = 1
                }
                else{
                    self.type.selectedSegmentIndex = 2
                }
                let gender = data["gender"] as? String ?? ""
                if gender == "М"{
                    self.gender.selectedSegmentIndex = 1
                }
                else{
                    self.gender.selectedSegmentIndex = 2
                }
                self.carbo.text = data["carbo"] as? String ?? ""
                let sugar = data["sugar"] as? String ?? ""
                if sugar == "ммоль/л"{
                    self.sugar.selectedSegmentIndex = 1
                }
                else{
                    self.sugar.selectedSegmentIndex = 2
                }
            } else {
                print("Couldn't find the document")
            }
        }

    }
    func getData(){
        Database.database().reference().child("patients").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value, with: { [self](snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject]{
                self.usernameLbl.text = dictionary["username"] as? String
            
            }
        },withCancel:nil)
    }
    @IBAction func carboValue(_ sender: UIStepper) {
        carbo.text = String(Double(carbo.text!)!+sender.value)
    }
    func validateFields() -> String? {
        if usernameLbl.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  dateLbl.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || carbo.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            goalS.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || HighS.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || LowS.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        return nil
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }
    
    
    @IBAction func resetBtn(_ sender: Any) {
        let resetViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? ResetViewController
        
        view.window?.rootViewController = resetViewController
        view.window?.makeKeyAndVisible()
    }
    @IBAction func saveBtn(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            showAlert(title: "Error!!!", message: error!)
        }
        else{
            let username = usernameLbl.text!.trimmingCharacters(in: .whitespacesAndNewlines)
          
            let birthdate = dateLbl.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let carboV = carbo.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let goal = goalS.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let high = HighS.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let low = LowS.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
                let db = Firestore.firestore()
                db.collection("patients").document(Auth.auth().currentUser!.uid).updateData(["username":username,"birthdate":birthdate,"carbo":carboV,"goalS":goal,"highS":high,"lowS":low])
                showAlert(title: "New Data", message: "We save your new data!")
        
    }
        }
    }
    

    
