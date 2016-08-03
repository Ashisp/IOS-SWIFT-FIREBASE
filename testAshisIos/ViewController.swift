//
//  ViewController.swift
//  testAshisIos
//
//  Created by bikram on 29/07/16.
//  Copyright © 2016 bikram. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import FirebaseAuth
import AlamofireObjectMapper
class ViewController: UIViewController {
 
    @IBOutlet weak var LoginFirebase: UIButton!
    @IBOutlet weak var textFieldToset: UITextField!
    @IBOutlet var ObserverStarter: UIView!
    @IBOutlet weak var textView2: UILabel!
    var ref: FIRDatabaseReference!
    @IBOutlet weak var textView1: UILabel!
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var buttonClick: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    self.ref = FIRDatabase.database().reference()

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func SetDataToFirebase(sender: UIButton) {
        self.ref.child("message").setValue(textFieldToset.text)

        
    }
    @IBAction func LoginFirebase(sender: UIButton) {
        
        
        
        //Firebase Authentication
        FIRAuth.auth()?.signInAnonymouslyWithCompletion() { (user, error) in
            
            //let isAnonymous = user!.anonymous  // true
            let uid = user!.uid
            print("logged in"+uid)
            
            
        }
        
    }
    @IBAction func ButtonOnClickListener(sender: UIButton) {
        // onChild added Eventlister
        self.ref.child("message").observeEventType(.Value, withBlock: { (snapshot) in
 //           print(snapshot.value!["message"] as? String)
                         self.textView1.text = snapshot.value as? String

         
           
            
                      //Snapshot gives all the data that are added on the eventlistener fired
            
        })
        
        
    }
    @IBAction func buttonOnClickListener(sender: UIButton) {
        
        
        
        let URL = "https://raw.githubusercontent.com/tristanhimmelman/AlamofireObjectMapper/d8bb95982be8a11a2308e779bb9a9707ebe42ede/sample_json"
        //using alamofireobjectmapper
        
        Alamofire.request(.GET, URL).validate(statusCode:200..<300).responseObject { (response: Response<WeatherResponse, NSError>) in
            
            let weatherResponse = response.result.value
            print(weatherResponse?.location)
            
            if let threeDayForecast = weatherResponse?.threeDayForecast {
                for forecast in threeDayForecast {
                    print(forecast.day)
                    print(forecast.conditions)
                    
                    self.textView!.text=forecast.day
                    
                    self.textView1.text=forecast.conditions;
                    self.textView2.text=String(forecast.temperature)
                    
                    
                    
                }
            }
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

