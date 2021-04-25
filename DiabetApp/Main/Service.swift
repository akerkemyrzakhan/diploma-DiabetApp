//
//  Service.swift
//  DiabetApp
//
//  Created by Мырзахан Акерке on 01.04.2021.
//

import UIKit
import Firebase
import FirebaseDatabase

class Service {
   
    static func createAlertController(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okAction)
        
        return alert
    }
}
