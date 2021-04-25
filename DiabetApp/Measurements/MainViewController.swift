//
//  MainViewController.swift
//  DiabetApp
//
//  Created by Мырзахан Акерке on 30.03.2021.
//

import UIKit
import Firebase
import FirebaseFirestore
import CoreData

class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
   

    let tableView = UITableView()
    
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    var sugarVr = "0.0"
    var foodVr = "0.0"
    var insulinShVr = "0.0"
    var insulinLnVr = "0.0"
    var commentVr = ""
    var strDate = ""
    var strD = ""
    var measurement:[Measurement] = []
    
    @IBOutlet weak var sliderOutlet: UISlider!
    
    @IBOutlet weak var labelText: UILabel!
    
    @IBOutlet weak var valueText: UILabel!
    
    @IBOutlet weak var measureText: UILabel!
    
    @IBOutlet weak var text1: UILabel!
    
    @IBOutlet weak var text2: UILabel!
    
    @IBOutlet weak var text3: UILabel!
    
    @IBOutlet weak var text4: UILabel!
    
    let comment1: UITextField = UITextField(frame: CGRect(x: 42, y: 297, width: 334.00, height: 130.00))
    
    @IBOutlet weak var backwardOutlet: UIButton!
    
    @IBOutlet weak var forwardOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = DateFormatter.Style.long
            dateFormatter.timeStyle = DateFormatter.Style.long
        
        let dateF = DateFormatter()
        dateF.dateStyle = DateFormatter.Style.short
        dateF.timeStyle = DateFormatter.Style.short
        strD = dateF.string(from: datePickerOutlet.date)

            strDate = dateFormatter.string(from: datePickerOutlet.date)
        measurement = loadMeasurement()
        tableView.register(UINib(nibName: String(describing: CustomTableViewCell.self), bundle: nil), forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.estimatedRowHeight = 300
        tableView.delegate = self
        tableView.dataSource = self
        if(measurement.count >= 1){
            text1.alpha = 0
            text2.alpha = 0
            text3.alpha = 0
            text4.alpha = 0
            
            tableView.alpha = 1
            tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 300
            
            view.addSubview(tableView)
            self.tableView.reloadData()

        }
        

        // Do any additional setup after loading the view.
    }


    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
        tableView.frame = CGRect(x: 20, y: 549, width: 374, height: 264)
    }
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return measurement.count
    }
  
    func loadMeasurement()-> [Measurement]{
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<Measurement>(entityName: "Measurement")
            do{
                try measurement = context.fetch(fetchRequest)
            }catch{
                print("Error!")
            }
        }
        return measurement
    }
   
    func saveMeasurement(_ sugarVr: String, _ foodVr: String, _ insulinShVr: String, _ insulinLnVr: String, _ commentVr: String, _ strDate: String){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            if let entity = NSEntityDescription.entity(forEntityName: "Measurement", in: context){
                let measurem = NSManagedObject(entity: entity, insertInto: context)
                measurem.setValue(sugarVr,forKey:"sugarVr")
                measurem.setValue(foodVr,forKey:"foodVr")
                measurem.setValue(insulinShVr,forKey:"insulinShVr")
                measurem.setValue(insulinLnVr,forKey:"insulinLnVr")
                measurem.setValue(commentVr,forKey:"commentVr")
                measurem.setValue(strD,forKey:"strDate")
                do{
                    try context.save()
                    measurement.append(measurem as! Measurement)
                }catch{
                    print("Warning! Error is here!")
                }
                
            }
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

       guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else {fatalError("Unabel to create cell")}
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.date.text = measurement[indexPath.row].strDate
        cell.date.alpha = 1
        cell.sugarImage.image = UIImage(named: "Group 167")
        cell.sugarImage.alpha = 1
        cell.sugar.text = measurement[indexPath.row].sugarVr
        cell.sugar.alpha = 1
      cell.foodImage.image = UIImage(named: "Group 163")
      cell.foodImage.alpha = 1
        cell.food.text = measurement[indexPath.row].foodVr
        cell.food.alpha = 1
       cell.insulinShImage.image = UIImage(named:"Group 164 (1)")
       cell.insulinShImage.alpha = 1
        cell.insulinSh.text = measurement[indexPath.row].insulinShVr
        cell.insulinSh.alpha = 1
      cell.insulinLnImage.image = UIImage(named: "Group 165")
     cell.insulinLnImage.alpha = 1
        cell.insulinLn.text = measurement[indexPath.row].insulinLnVr
        cell.insulinLn.alpha = 1
     cell.commentImage.image = UIImage(named: "Group 166")
       cell.commentImage.alpha = 1
        cell.comment.text = measurement[indexPath.row].commentVr
        cell.comment.alpha = 1
        return cell
    }
    
    @IBAction func sugarButton(_ sender: Any) {
        if labelText.text == "Еда" {
            foodVr = valueText.text!
            sliderOutlet.value = 0
        }
        if labelText.text == "Короткий инсулин" {
            insulinShVr = valueText.text!
            sliderOutlet.value = 0
        }
        if labelText.text == "Продленный инсулин" {
            insulinLnVr = valueText.text!
            sliderOutlet.value = 0
        }
        if labelText.text == "Комментарий" {
            commentVr = comment1.text!
            
        }
        labelText.text = "Сахар"
        measureText.text =  "ммоль/л"
        comment1.alpha = 0
        valueText.text = "0.0"
        forwardOutlet.alpha = 1
        backwardOutlet.alpha = 0
        sliderOutlet.alpha = 1
        measureText.alpha = 1
        valueText.alpha = 1
    }
    
    @IBAction func foodButton(_ sender: Any) {
        if labelText.text == "Сахар" {
            sugarVr = valueText.text!
            sliderOutlet.value = 0
        }
        if labelText.text == "Короткий инсулин" {
            insulinShVr = valueText.text!
            sliderOutlet.value = 0
        }
        if labelText.text == "Продленный инсулин" {
            insulinLnVr = valueText.text!
            sliderOutlet.value = 0
        }
        if labelText.text == "Комментарий" {
            commentVr = comment1.text!
            
        }
        labelText.text = "Еда"
        measureText.text = "ХЕ"
        comment1.alpha = 0
        valueText.text = "0.0"
        forwardOutlet.alpha = 1
        backwardOutlet.alpha = 1
        sliderOutlet.alpha = 1
        measureText.alpha = 1
        valueText.alpha = 1
    }
    
    @IBAction func insulinSh(_ sender: Any) {
        if labelText.text == "Еда" {
            foodVr = valueText.text!
            sliderOutlet.value = 0
        }
        if labelText.text == "Сахар" {
            sugarVr = valueText.text!
            sliderOutlet.value = 0
        }
        if labelText.text == "Продленный инсулин" {
            insulinLnVr = valueText.text!
            sliderOutlet.value = 0
        }
        if labelText.text == "Комментарий" {
            commentVr = comment1.text!
            
        }
        labelText.text = "Короткий инсулин"
        measureText.text = "ед"
        comment1.alpha = 0
        valueText.text = "0.0"
        forwardOutlet.alpha = 1
        backwardOutlet.alpha = 1
        sliderOutlet.alpha = 1
        measureText.alpha = 1
        valueText.alpha = 1
    }
    
    @IBAction func insulinLng(_ sender: Any) {
        if labelText.text == "Еда" {
            foodVr = valueText.text!
            sliderOutlet.value = 0
        }
        if labelText.text == "Короткий инсулин" {
            insulinShVr = valueText.text!
            sliderOutlet.value = 0
        }
        if labelText.text == "Сахар" {
            sugarVr = valueText.text!
            sliderOutlet.value = 0
        }
        if labelText.text == "Комментарий" {
            commentVr = comment1.text!
            
        }
        labelText.text = "Продленный инсулин"
        measureText.text = "ед"
        comment1.alpha = 0
        valueText.text = "0.0"
        forwardOutlet.alpha = 1
        backwardOutlet.alpha = 1
        sliderOutlet.alpha = 1
        measureText.alpha = 1
        valueText.alpha = 1
    }
    
    @IBAction func comments(_ sender: Any) {
        if labelText.text == "Еда" {
            foodVr = valueText.text!
            sliderOutlet.value = 0
        }
        if labelText.text == "Короткий инсулин" {
            insulinShVr = valueText.text!
            sliderOutlet.value = 0
        }
        if labelText.text == "Продленный инсулин" {
            insulinLnVr = valueText.text!
            sliderOutlet.value = 0
        }
        if labelText.text == "Сахар" {
            sugarVr = comment1.text!
            sliderOutlet.value = 0
            
        }
        labelText.text = "Комментарий"
        sliderOutlet.alpha = 0
        valueText.alpha = 0
        measureText.alpha = 0
        comment1.placeholder = "Введите ваш комментарии..."
        comment1.tintColor = UIColor(named: "AccentColor")
        comment1.borderStyle = UITextField.BorderStyle.none
        comment1.alpha = 1
        self.view.addSubview(comment1)
        forwardOutlet.alpha = 0
        backwardOutlet.alpha = 1
    }
    @IBAction func sliderChanged(_ sender: UISlider) {
        valueText.text = String(Int(sender.value))
    }
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }


    @IBAction func saveButton(_ sender: Any) {
        commentVr=comment1.text!
        let date = strDate
        let db = Firestore.firestore()
        //print(userId)
        db.collection("patients").document(Auth.auth().currentUser!.uid).setData(["allM":[date: ["foodM":foodVr,"sugarM":sugarVr,"insulinSHM":insulinShVr,"insulinLNM":insulinLnVr,"commentM":commentVr,"date":strDate]]], merge: true)
        
        showAlert(title: "New Data", message: "We save your new data!")
        //measurement.append(Measurement.init(sugarVr, foodVr, insulinShVr, insulinLnVr, commentVr, strD))
        self.saveMeasurement(sugarVr, foodVr, insulinShVr, insulinLnVr, commentVr, strDate)
        self.tableView.reloadData()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        
        
        
        if(measurement.count >= 1){
            text1.alpha = 0
            text2.alpha = 0
            text3.alpha = 0
            text4.alpha = 0
            
            tableView.alpha = 1
            tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 300
            //tableView.numberOfRows(inSection: 0)
            
            view.addSubview(tableView)
            self.tableView.reloadData()

        }
        
    }
    
    @IBAction func forwardButton(_ sender: Any) {
        if labelText.text == "Еда" {
            foodVr = valueText.text!
            sliderOutlet.value = 0
            labelText.text = "Короткий инсулин"
            measureText.text = "ед"
            comment1.alpha = 0
            valueText.text = "0.0"
            forwardOutlet.alpha = 1
        }
        if labelText.text == "Короткий инсулин" {
            insulinShVr = valueText.text!
            sliderOutlet.value = 0
            labelText.text = "Продленный инсулин"
            measureText.text = "ед"
            comment1.alpha = 0
            valueText.text = "0.0"
            forwardOutlet.alpha = 1
        }
        if labelText.text == "Сахар" {
            sugarVr = valueText.text!
            sliderOutlet.value = 0
            labelText.text = "Еда"
            measureText.text = "ХЕ"
            comment1.alpha = 0
            valueText.text = "0.0"
            forwardOutlet.alpha = 1
        }
        if labelText.text == "Продленный инсулин" {
            insulinLnVr = valueText.text!
            sliderOutlet.value = 0
            sliderOutlet.alpha = 0
            labelText.text = "Комментарий"
            valueText.alpha = 0
            measureText.alpha = 0
            forwardOutlet.alpha = 1

            
        }
        if labelText.text == "Комментарий" {
            forwardOutlet.alpha = 0
            comment1.alpha = 1
            comment1.placeholder = "Введите ваш комментарии..."
            comment1.tintColor = UIColor(named: "AccentColor")
            comment1.borderStyle = UITextField.BorderStyle.none
            self.view.addSubview(comment1)
      
        }
    }
    
    @IBAction func backwardButton(_ sender: Any) {
        if labelText.text == "Сахар" {
            backwardOutlet.alpha = 0
            sliderOutlet.alpha = 1
            measureText.alpha = 1
            valueText.alpha = 1
        }
        if labelText.text == "Еда" {
            foodVr = valueText.text!
            sliderOutlet.value = 0
            labelText.text = "Сахар"
            measureText.text = "ммоль/л"
            comment1.alpha = 0
            valueText.text = "0.0"
            backwardOutlet.alpha = 0
            sliderOutlet.alpha = 1
            measureText.alpha = 1
            valueText.alpha = 1
        }
        if labelText.text == "Короткий инсулин" {
            insulinShVr = valueText.text!
            sliderOutlet.value = 0
            labelText.text = "Еда"
            measureText.text = "ХЕ"
            comment1.alpha = 0
            valueText.text = "0.0"
            backwardOutlet.alpha = 1
            sliderOutlet.alpha = 1
            measureText.alpha = 1
            valueText.alpha = 1
        }
        if labelText.text == "Продленный инсулин" {
            insulinLnVr = valueText.text!
            sliderOutlet.value = 0
            labelText.text = "Короткий инсулин"
            measureText.text = "ед"
            comment1.alpha = 0
            valueText.text = "0.0"
            backwardOutlet.alpha = 1
            sliderOutlet.alpha = 1
            measureText.alpha = 1
            valueText.alpha = 1
            
            
        }
        if labelText.text == "Комментарий" {
            
            commentVr = comment1.text!
            sliderOutlet.value = 0
            sliderOutlet.alpha = 1
            labelText.text = "Продленный инсулин"
            measureText.text = "ед"
            measureText.alpha = 1
            comment1.alpha = 0
            valueText.text = "0.0"
            valueText.alpha = 1
            backwardOutlet.alpha = 1
            forwardOutlet.alpha = 1
            
            
        }

        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteMeasurement(measurement[indexPath.row])
            measurement = loadMeasurement()
            tableView.reloadData()
        }
    }

    func deleteMeasurement(_ object:Measurement){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            context.delete(object)
            do{
                try context.save()
            }
            catch{
                
            }
    }
    
    
}
}
