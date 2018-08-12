//
//  PlayerSingleton.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 8/12/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

class PlayerSingleton {
    static let sharedInstance = PlayerSingleton()
    var player: SPTAudioStreamingController?
    var spotifyAuthUtils: SpotifyAuthUtils?
    
    init() {
        print("The player singleton object has been created")
        createPlayer()
    }
    
    fileprivate func createPlayer() {
        spotifyAuthUtils = SpotifyAuthUtils()
        
        if let authToken = spotifyAuthUtils?.readAuthToken() {
            if self.player == nil {
                self.player = SPTAudioStreamingController.sharedInstance()
                try! player!.start(withClientId: spotifyAuthUtils?.auth?.clientID)
                self.player!.login(withAccessToken: authToken.accessToken)
            }
        }
    }
}
