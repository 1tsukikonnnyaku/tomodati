//
//  ViewController.swift
//  tomodati
//
//  Created by 海月 on 2022/07/06.
//

import UIKit

class AddEventViewController: UIViewController {
    
    
    @IBOutlet  var titleTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var contentTextview: UITextView!
    @IBOutlet var placeTextFiled: UITextField!
    @IBOutlet var usernameTextFiled1: UITextField!
    @IBOutlet var usernameTextFiled2: UITextField!
    
    
    var eventArray = [EventData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let savedData = UserDefaults.standard.data(forKey: "Eventarray"), let decoded = try? JSONDecoder().decode([EventData].self, from: savedData) {
          eventArray = decoded
            print(eventArray)
//            eventArray[0].title
//            titleTextField.text = decoded[0].title
//            datePicker.date = decoded[0].date
        }
    }
    
    
    @IBAction func add(){
        let eventData = EventData(title: titleTextField.text!, date: datePicker.date,content: contentTextview.text!,place: placeTextFiled.text!,username1: usernameTextFiled1.text!,username2: usernameTextFiled2.text!)
        eventArray.append(eventData)
        if let encoded = try?JSONEncoder().encode(eventArray){UserDefaults.standard.set(encoded,forKey: "Eventarray")}
    }
    
}
