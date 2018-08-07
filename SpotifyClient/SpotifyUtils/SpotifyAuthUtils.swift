//
//  SpotifyAuthUtils.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 8/1/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import Foundation

class SpotifyAuthUtils {
    var clientId = ""
    var redirectUrl = URL(string: "SpotifyClient://returnAfterLogin")
    var loginUrl: URL?
    let auth = SPTAuth.defaultInstance()
    
    init() {
        // Try to read the env var
        if let env_var_client_id = ProcessInfo.processInfo.environment["spotifyClientId"] {
            clientId = env_var_client_id
            
            auth?.clientID = clientId
            auth?.redirectURL = redirectUrl
            auth?.requestedScopes = [SPTAuthStreamingScope]
            
            loginUrl = auth?.spotifyWebAuthenticationURL()
        } else {
            print("Could not read the environment variable - client id")
        }
    }
    
    func didMount() {
        UIApplication.shared.open(loginUrl!, options: [:], completionHandler: nil)
    }
    
    func readAuthToken() -> SPTSession? {
        let userDefaults = UserDefaults.standard
        if let sessionObj:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            
            return firstTimeSession
        } else {
            return nil
        }
    }
}
