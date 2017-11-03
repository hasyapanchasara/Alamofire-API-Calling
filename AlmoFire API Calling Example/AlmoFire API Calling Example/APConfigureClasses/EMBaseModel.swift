//
//  EMBaseModel.swift
//  AlmoFire API Calling Example
//
//  Created by Hasya.Panchasara on 03/11/17.
//  Copyright © 2017 Hasya Panchasara. All rights reserved.
//


import Foundation

class EMBaseModel {
    

    var status: String?
    var success: String?
    var message : String?
    
    init(jsonDict: Dictionary<String, AnyObject>) {
        
        self.status = jsonDict[EMAPIResponseStatusKeys.status] as? String
        self.message = jsonDict[EMAPIResponseStatusKeys.message] as? String
    }
}

class EMResponseModel {
    
    var status: String?
    var success: String?
    var message : String?
    var data : Dictionary<String,AnyObject>?
    var tokenData : Dictionary<String,AnyObject>?
    
    init(jsonDict: Dictionary<String, AnyObject>) {
        
        self.status = jsonDict[EMAPIResponseStatusKeys.status] as? String
        self.message = jsonDict[EMAPIResponseStatusKeys.message] as? String
        
        if(self.status == EMAPIResponseStatusKeys.success){
            data = jsonDict[EMAPIResponseStatusKeys.data] as? Dictionary<String,AnyObject>
        }
        
        if jsonDict[EMAPIResponseStatusKeys.tokenData] != nil {
            tokenData = jsonDict[EMAPIResponseStatusKeys.tokenData] as? Dictionary<String,AnyObject>
        }
        
    }
}


