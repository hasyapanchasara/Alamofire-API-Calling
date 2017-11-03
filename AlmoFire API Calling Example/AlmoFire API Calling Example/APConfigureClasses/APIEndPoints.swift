//
//  APIEndPoints.swift
//  AlmoFire API Calling Example
//
//  Created by Hasya.Panchasara on 03/11/17.
//  Copyright © 2017 Hasya Panchasara. All rights reserved.
//

import Foundation

class APIEndPoints {
    static func getBaseURL() -> String {
        return "http://APIEndPointURL" // API End Point URL
        
    }

    static func getAPIVersion() -> String {
        return getBaseURL() + "v1/"
    }

    static func getLoginURL() -> String {
        return getAPIVersion() + "login"
    }
    
}
