//
//  ViewController.swift
//  AlmoFire API Calling Example
//
//  Created by Hasya.Panchasara on 03/11/17.
//  Copyright © 2017 Hasya Panchasara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.API_Formation_Function("email@email.com", password: "password12345")
    }

    
    func API_Formation_Function(_ userName : String , password : String) {
        
        
        
        EMReqeustManager.sharedInstance.apiLogin(userName, password: password) {
            (feedResponse) -> Void in
            
                // Show your progress HUD here
            
            if let downloadError = feedResponse.error{

                // Hide progress HUD here and show error if comes
            
            } else {
                if let dictionary = feedResponse.responseDict as? Dictionary<String, AnyObject>{
            
                    // Hide progress HUD here and show response
                    
                    let responseModel = EMResponseModel.init(jsonDict: dictionary)
                    
                    print(responseModel)
                    
                    print("Username and password is correct")
                 
                    
                }
            }
        }
       
        
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

