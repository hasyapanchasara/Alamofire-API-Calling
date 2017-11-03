//
//  GLOBAL.swift
//  AlmoFire API Calling Example
//
//  Created by Hasya.Panchasara on 01/11/17.
//  Copyright © 2017 Hasya Panchasara. All rights reserved.
//

import Foundation
import UIKit
import ReachabilitySwift

struct APPLICATION
{
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
    static var APP_STATUS_BAR_COLOR = UIColor(red: CGFloat(27.0/255.0), green: CGFloat(32.0/255.0), blue: CGFloat(42.0/255.0), alpha: 1)
    static var APP_NAVIGATION_BAR_COLOR = UIColor(red: CGFloat(41.0/255.0), green: CGFloat(48.0/255.0), blue: CGFloat(63.0/255.0), alpha: 1)
    static let applicationName = "HasyaHP"
}


struct EMAPIResponseStatusKeys {
    static let success = "success"
    static let message = "message"
    static let status = "status"
    static let data = "data"
    static let tokenData = "tokendata"
}

struct EMError{
    static let domain = "CVErrorDomain"
    static let networkCode = -1
    static let userInfoKey = "description"
}


struct ValidationMessageKeys {
    static let name = "name"
    static let userName = "user name"
    static let emailID = "email address"
    static let password = "password"
    static let oldPassword = "old password"
    static let newPassword = "new password"
    static let confirmPassword = "confirm password"
    static let phoneNumber = "phone number"
    static let description = "description"
}

struct EMUserTypes{
    static let socialTypeFacebook = 1
    static let socialTypeGmail = 2
    static let socialTypeNormal = 0
}

struct EMAPIRequestKeys {
    static let userID = "UserId"
    static let userName = "Name"
    static let password = "Password"
    static let emailID = "Email"
    static let profilePic = "ProfilePic"
    static let versionCode = "versionCode"
    static let versionOne = "1"
    static let getEmojiRequestType = "Type"
    static let getAppId = "AppId"
    static let emojiType = "Emojis"
    static let stickersType = "Stickers"
    static let appIDs = "AppIDs"
    static let CategoryType = "CategoryType"
    static let Page = "Page"
    static let isSocialUser = "isSocialUser"
    static let socialId = "SocialId"
    static let socialType = "SocialType"
    static let devicePushToken = "DevicePushToken"
    static let deviceType = "DeviceType"
    static let normalUser = "0"
    static let socialUser = "1"
    static let deviceTypeIOS = "ios"
    static let oldPassword = "OldPassword"
    static let newPassword = "NewPassword"
    static let enableOrDisableSettings = "EnableOrDisable"
    static let requestTimeOutForNoramlAPIs = 60.0
    static let requestTimeOutForFileUploadAPIs = 240.0
    static let Name = "Name"
    static let Email = "Email"
    static let itemType = "Type"
    static let PhoneNumber = "PhoneNumber"
    static let Subject = "Subject"
    static let Description = "Description"
    static let DevicePushToken = "DevicePushToken"
    static let DeviceType = "DeviceType"
    static let webdata = "webdata"
    static let appAboutUs = "app_about_us"
    static let appHeader = "Authorization"
}

struct EMUserInfoKeys {
    static let userID = "UserId"
    static let userName = "Name"
    static let emailID = "Email"
    static let profilePic = "ProfilePic"
    static let isSocialUser = "isSocialUser"
    static let socialId = "SocialId"
    static let devicePushToken = "DevicePushToken"
    static let deviceType = "DeviceType"
    static let userType = "userType"
    static let accessToken = "accessToken"
    static let refreshToken = "refreshToken"
    static let tokenType = "tokenType"
    static let tokenBearer = "Bearer"
    static let tokenExpiresIn = "tokenExpiresIn"
    static let isUserLoggedIn = "isUserLoggedIn"
    static let isNotificationEnabled = "isNotificationEnabled"
}

class GLOBAL : NSObject {
    
    //sharedInstance
    static let sharedInstance = GLOBAL()
    
    
    //MARK: - Internet Reachability
    var reachability: Reachability?
    var isInternetReachable : Bool? = false
    
    func setupReachability(_ hostName: String?) {
        
       GLOBAL.sharedInstance.reachability = hostName == nil ? Reachability() : Reachability(hostname: hostName!)
        
        if reachability?.isReachable == true
        {
             GLOBAL.sharedInstance.isInternetReachable = true
        }
        
        NotificationCenter.default.addObserver(GLOBAL.sharedInstance, selector: #selector(reachabilityChanged(_:)), name: ReachabilityChangedNotification, object: nil)
    }
    
    func startNotifier() {
        
        setupReachability("google.com")
        
        print("--- start notifier")
        do {
            try GLOBAL.sharedInstance.reachability?.startNotifier()
        } catch {
            print("Unable to create Reachability")
            return
        }
    }
    
    func stopNotifier() {
        print("--- stop notifier")
        GLOBAL.sharedInstance.reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: nil)
        GLOBAL.sharedInstance.reachability = nil
    }
    
    @objc func reachabilityChanged(_ note: Notification) {
        let reachability = note.object as! Reachability
        
        if reachability.isReachable {
            GLOBAL.sharedInstance.isInternetReachable = true
        } else {
            GLOBAL.sharedInstance.isInternetReachable = false
        }
    }
    
   
}

