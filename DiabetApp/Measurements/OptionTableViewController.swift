//
//  OptionTableViewController.swift
//  DiabetApp
//
//  Created by Мырзахан Акерке on 01.04.2021.
//

import UIKit
import FittedSheets

class OptionTableViewController: UITableViewController {
    let options: [String] = ["Новорапид", "Хумалог", "Хумулин", "Новолог", "Лантус"]
    let titleOFOptions = "Короткий инсулин"
    var isCompleted: ((_ selectedOption: String) -> ())? = nil
    
    func didSelectedOption(completed: @escaping(_ selectedOption: String) -> ()){
        self.isCompleted = completed
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return options.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = options[indexPath.row]
       

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let completed = isCompleted{
            completed(options[indexPath.row])
        }
        
    }
    
}
