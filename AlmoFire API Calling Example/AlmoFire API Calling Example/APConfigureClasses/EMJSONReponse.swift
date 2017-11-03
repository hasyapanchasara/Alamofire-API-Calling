//
//  EMJSONReponse.swift
//  AlmoFire API Calling Example
//
//  Created by Hasya.Panchasara on 03/11/17.
//  Copyright © 2017 Hasya Panchasara. All rights reserved.
//


import Foundation

import Foundation

class EMJSONReponse {
    let data: Dictionary<String, AnyObject>?
    let response: URLResponse?
    var error: Error?
    var message : String?
    
    init(data: Dictionary<String, AnyObject>?, response: URLResponse?,error: Error?){
        self.data = data
        self.response = response
        self.error = error
        
        //If not error
        if (self.error == nil) {
            
            if let feedDict = data {
                
                let baseModel = EMBaseModel.init(jsonDict: feedDict)
                message = baseModel.message
                //If feed retrival is success
                if(baseModel.status != EMAPIResponseStatusKeys.success){
                    if let message  = baseModel.message {
                        if self.HTTPResponse.statusCode != 200 {
                            self.error = NSError(domain:EMError.domain, code: self.HTTPResponse.statusCode, userInfo:[NSLocalizedDescriptionKey:message])
                        } else {
                            self.error = NSError(domain:EMError.domain, code:7777 , userInfo:[NSLocalizedDescriptionKey:message])
                        }
                    }
                }
                
            }
            
        }
    }
    
    init(error: Error? ,dataDict : NSDictionary ){
        self.data = nil
        self.response = nil
        self.error = error
    }
    
    var HTTPResponse: HTTPURLResponse! {
        return response as? HTTPURLResponse
    }
    
    var responseDict: AnyObject? {
        return data as AnyObject?
    }
    
    var responseMessage: String? {
        return message 
    }
}
