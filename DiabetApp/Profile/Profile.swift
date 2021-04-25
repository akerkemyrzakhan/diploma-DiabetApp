//
//  Profile.swift
//  DiabetApp
//
//  Created by Мырзахан Акерке on 09.04.2021.
//

import UIKit
import Firebase
import FirebaseFirestore

class Profile: UIViewController {
    let vc = ProfileViewController()

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        firstView.alpha = 1
        secondView.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func switchViews(_ sender:UISegmentedControl){
        if sender.selectedSegmentIndex == 0{
            firstView.alpha = 1
            secondView.alpha = 0
            btn.setImage(UIImage(named: "image 52 (1)"), for: .normal)
            
        }
        else{
            firstView.alpha = 0
            secondView.alpha = 1
            btn.setImage(UIImage(named:"image 74"), for: .normal)
        }
    }
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }
    func validateFields() -> String? {
        if vc.height.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || vc.weight.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || vc.coeffch.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || vc.coefcarb.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
            return "Please fill in all fields."
        }
       
        return nil
    }
    
    
    @IBAction func saveBtn(_ sender: Any) {
        if firstView.alpha == 1{
        let error = validateFields()
        if error != nil {
            showAlert(title: "Error!!!", message: error!)
        }
        else{
            let heightV = vc.height.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let weightV = vc.weight.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let coeffchV = vc.coeffch.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let coefcarbV = vc.coefcarb.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pompV = vc.mySwitch
            
            let insulinShort = vc.choose.titleLabel?.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let insulinLong = vc.choose2.titleLabel!.text!.trimmingCharacters(in: .whitespacesAndNewlines)

                let db = Firestore.firestore()
                db.collection("patients").document(Auth.auth().currentUser!.uid).updateData(["height":heightV,"weight":weightV,"coeffch":coeffchV,"coefcarb":coefcarbV,"pomp":pompV,"insulinshort":insulinShort!,"insulinlong":insulinLong])
                showAlert(title: "New Data", message: "We save your new data!")
        
    }
        }
        else{
            do
               {
                   try Auth.auth().signOut()
//
                let viewController = self.storyboard?.instantiateViewController(identifier: "launchScreen") as! ViewController
                viewController.modalTransitionStyle = .crossDissolve
                viewController.modalPresentationStyle = .overFullScreen
                self.present(viewController, animated: true, completion: nil)
               }
               catch let error as NSError
               {
                   print(error.localizedDescription)
               }

        }


}
}

