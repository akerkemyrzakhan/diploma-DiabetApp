//
//  ProfileViewController.swift
//  DiabetApp
//
//  Created by Мырзахан Акерке on 01.04.2021.
//

import UIKit
import FittedSheets
import Firebase


class ProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var num = 0
    
    let options = ["Новорапид", "Хумалог", "Хумулин", "Новолог", "Лантус"]

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var height: UITextField!
    
    @IBOutlet weak var choose: UIButton!
    
    @IBOutlet weak var choose2: UIButton!
    
    @IBOutlet weak var weight: UITextField!
    
    @IBOutlet weak var coefcarb: UITextField!
    
    @IBOutlet weak var coeffch: UITextField!
    
    var mySwitch = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.isHidden = true
        picker.delegate = self
        picker.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if num == 1{
        choose.setTitle(options[row], for: .normal)
        }
        if num == 2{
            choose2.setTitle(options[row], for: .normal)
        }
        picker.isHidden = true
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }
    
    func validateFields() -> String? {
        if height.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || weight.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || coeffch.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || coefcarb.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
            return "Please fill in all fields."
        }
       
        return nil
    }
    
    @IBAction func isSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            mySwitch = "Yes"
        }
        else{
            mySwitch = "No"
        }
    }
    

    
    @IBAction func chooseButton(_ sender: Any) {

        if picker.isHidden {
            picker.isHidden = false
            picker.delegate = self
            picker.dataSource = self
            num = 1
        }
        
        
        
    }
    
    @IBAction func choose2(_ sender: UIButton) {
        if picker.isHidden{
            picker.isHidden = false
            num = 2
            
        }
    }
    
    @IBAction func forwardToStatistics(_ sender: Any) {

        let viewController = self.storyboard?.instantiateViewController(identifier: "statistics") as! StatisticsViewController
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overFullScreen
        self.present(viewController, animated: true, completion: nil)
    }


}



