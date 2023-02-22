//
//  ViewController.swift
//  tomodati
//
//  Created by 海月 on 2022/07/06.
//

import UIKit
import Firebase
import FirebaseFirestore


class AddEventViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var contentTextview: UITextView!
    @IBOutlet var placeTextFiled: UITextField!
    @IBOutlet var usernameTextFiled1: UITextField!
    @IBOutlet var usernameTextFiled2: UITextField!
    
    
    var eventArray = [EventData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func add(){
        let eventData = EventData(date: datePicker.date,topic: contentTextview.text!,spot: placeTextFiled.text!,user1: usernameTextFiled1.text!,user2: usernameTextFiled2.text!)
       
        do{
            try db.collection("events").document().setData(from: eventData)
        } catch let error {
            print("Error writing eventDate to Firestore: \(error)")
        }
        
        eventArray.append(eventData)
        
        if let encoded = try?JSONEncoder().encode(eventArray){UserDefaults.standard.set(encoded,forKey: "Eventarray")}
    }
    
}
