//
//  EMReqeustManager.swift
//  AlmoFire API Calling Example
//
//  Created by Hasya.Panchasara on 03/11/17.
//  Copyright © 2017 Hasya Panchasara. All rights reserved.
//


import Foundation

import Foundation
import Alamofire

typealias requestCompletionHandler = (EMJSONReponse) -> Void

class EMReqeustManager: NSObject {
    static let sharedInstance = EMReqeustManager()
    
    fileprivate override init() {
        super.init()
        
        
    }
    
    fileprivate func sendRequestWithURL(_ URL: String,
                                        method: HTTPMethod,
                                        queryParameters: [String: String]?,
                                        bodyParameters: [String: AnyObject]?,
                                        headers: [String: String]?,
                                        isLoginHeaderRequired:Bool,
                                        retryCount: Int = 0,
                                        needsLogin: Bool = false,
                                        completionHandler:@escaping requestCompletionHandler) {
        // If there's a querystring, append it to the URL.
        
        if (GLOBAL.sharedInstance.isInternetReachable == false) {
            let userInfo: [NSObject : AnyObject] =
                [
                    NSLocalizedDescriptionKey as NSObject :  NSLocalizedString("No Internet", value: "No Internet Connection is there.", comment: "") as AnyObject,
                    NSLocalizedFailureReasonErrorKey as NSObject : NSLocalizedString("No Internet", value: "No Internet Connection is there.", comment: "") as AnyObject
            ]
            

            let error : NSError = NSError(domain: "EnomjiHttpResponseErrorDomain", code: -1, userInfo: userInfo as! [String : Any])
            let wrappedResponse = EMJSONReponse.init(error: error, dataDict: [:])
            completionHandler(wrappedResponse)
            print(error)
            return
        }
        
        let actualURL: String
        if let queryParameters = queryParameters {
            var components = URLComponents(string:URL)!
            components.queryItems = queryParameters.map { (key, value) in URLQueryItem(name: key, value: value) }
            actualURL = components.url!.absoluteString
        } else {
            actualURL = URL
        }
        
        var headerParams = [String: String]()
        if let headers = headers {
            headerParams = headers
        }
        
        print("Actual URL \(actualURL)")
        
        Alamofire.request(actualURL, method:method, parameters: bodyParameters, headers: headerParams)
            .responseJSON { response in
                print(response.result)   // result of response serialization
                
                switch response.result {
                case .success:
                    
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        print("JSON: \(JSON)")
                        
                        let wrappedResponse = EMJSONReponse.init(
                            data: response.result.value as! Dictionary<String, AnyObject>?,
                            response: response.response,
                            error: nil)
                        
                        DispatchQueue.main.async(execute: {
                            completionHandler(wrappedResponse)
                        })
                    }
                case .failure(let error):
                    let error = error
                    let wrappedResponse = EMJSONReponse.init(error: error, dataDict: [:])
                    completionHandler(wrappedResponse)
                    print(error)
                }
        }
    }
    
    
    fileprivate func sendRequestForFileUploadWithURL(_ URL: String,
                                        method: HTTPMethod,
                                        image: UIImage?,
                                        fileName : String?,
                                        queryParameters: [String: String]?,
                                        bodyParameters: [String: AnyObject]?,
                                        headers: [String: String]?,
                                        isLoginHeaderRequired:Bool,
                                        retryCount: Int = 0,
                                        needsLogin: Bool = false,
                                        completionHandler:@escaping requestCompletionHandler) {
        // If there's a querystring, append it to the URL.
        
        if (GLOBAL.sharedInstance.isInternetReachable == false) {
            let userInfo: [NSObject : AnyObject] =
                [
                    NSLocalizedDescriptionKey as NSObject :  NSLocalizedString("No Internet", value: "No Internet Connection is there.", comment: "") as AnyObject,
                    NSLocalizedFailureReasonErrorKey as NSObject : NSLocalizedString("No Internet", value: "No Internet Connection is there.", comment: "") as AnyObject
            ]
            
            let error : NSError = NSError(domain: "EnomjiHttpResponseErrorDomain", code: -1, userInfo: userInfo as? [String : Any])
            let wrappedResponse = EMJSONReponse.init(error: error, dataDict: [:])
            completionHandler(wrappedResponse)
            print(error)
            return
        }
        
        let actualURL: String
        if let queryParameters = queryParameters {
            var components = URLComponents(string:URL)!
            components.queryItems = queryParameters.map { (key, value) in URLQueryItem(name: key, value: value) }
            actualURL = components.url!.absoluteString
        } else {
            actualURL = URL
        }
        
        var headerParams = [String: String]()
        if let headers = headers {
            headerParams = headers
        }
        
        print("Actual URL \(actualURL)")
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            /*
            if let fileName = fileName {
                
                let fileUrl = NSURL(string: fileName)!
                
                if fileUrl.pathExtension!.lowercased() == "jpg" || fileUrl.pathExtension!.lowercased() == "jpeg" {
                    if let imageData = UIImageJPEGRepresentation(image!, 0.5) {
                        multipartFormData.append(imageData, withName: "ProfilePic", fileName: "ProfilePic.jpg", mimeType: "image/jpg")
                    }
                } else {
                    if let imageData = UIImagePNGRepresentation(image!) {
                        multipartFormData.append(imageData, withName: "ProfilePic", fileName: "ProfilePic.png", mimeType: "image/png")
                    }
                }
            } else {
                if let imageData = UIImagePNGRepresentation(image!) {
                    multipartFormData.append(imageData, withName: "ProfilePic", fileName: "ProfilePic.png", mimeType: "image/png")
                }
            }
            */
            
            if let imageData = UIImageJPEGRepresentation(image!, 0.75) {
                multipartFormData.append(imageData, withName: "ProfilePic", fileName: "ProfilePic.jpg", mimeType: "image/jpg")
            }
            
            
            for (key, value) in bodyParameters! {
                let paramValue = value as! String
                multipartFormData.append(paramValue.data(using: String.Encoding.utf8)!, withName: key)
            }}, to: actualURL, method: .post, headers: headerParams,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            print(response.request!)  // original URL request
                            print(response.result)   // result of response serialization
                            
                            switch response.result {
                            case .success:
                                if let result = response.result.value {
                                    let JSON = result as! NSDictionary
                                    print("JSON: \(JSON)")
                                    
                                    let wrappedResponse = EMJSONReponse.init(
                                        data: response.result.value as! Dictionary<String, AnyObject>?,
                                        response: response.response,
                                        error: nil)
                                    
                                    DispatchQueue.main.async(execute: {
                                        completionHandler(wrappedResponse)
                                    })
                                }
                            case .failure(let error):
                                let error = error
                                let wrappedResponse = EMJSONReponse.init(error: error, dataDict: [:])
                                completionHandler(wrappedResponse)
                                print(error)
                            }
                        }
                    case .failure(let encodingError):
                        let error = encodingError
                        let wrappedResponse = EMJSONReponse.init(error: error, dataDict: [:])
                        completionHandler(wrappedResponse)
                        print(error)
                    }
        })
    }

    
    
    
    
}

extension EMReqeustManager {
    
    func apiLogin(_ emailId : String, password : String, completionHandler:@escaping requestCompletionHandler) {
        var deviceToken = ""
        
        let bodyParams: [String: String] = [EMAPIRequestKeys.emailID: emailId,
                                            EMAPIRequestKeys.password: password ,
                                            EMAPIRequestKeys.userName : "" ,
                                            EMAPIRequestKeys.isSocialUser : EMAPIRequestKeys.normalUser ,
                                            EMAPIRequestKeys.socialType : String(EMUserTypes.socialTypeNormal),
                                            EMAPIRequestKeys.deviceType : EMAPIRequestKeys.deviceTypeIOS ,
                                            EMAPIRequestKeys.devicePushToken : deviceToken,
                                            EMAPIRequestKeys.socialId : ""
        ]
        
        sendRequestWithURL(APIEndPoints.getLoginURL(), method: .post, queryParameters: nil, bodyParameters: bodyParams as [String : AnyObject]?, headers: nil, isLoginHeaderRequired: false, completionHandler: completionHandler)
    }
    
}
