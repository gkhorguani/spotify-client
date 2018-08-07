//
//  PlayerViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 8/6/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    var player: SPTAudioStreamingController?
    var spotifyAuthUtils: SpotifyAuthUtils?

    override func viewDidLoad() {
        super.viewDidLoad()

        spotifyAuthUtils = SpotifyAuthUtils()
        
        if let authToken = spotifyAuthUtils?.readAuthToken() {
            initializePlayer(authSession: authToken)
        }
    }
    
    func initializePlayer(authSession:SPTSession){
        if self.player == nil {
            self.player = SPTAudioStreamingController.sharedInstance()
            self.player!.playbackDelegate = self
            self.player!.delegate = self
            try! player!.start(withClientId: spotifyAuthUtils?.auth?.clientID)
            self.player!.login(withAccessToken: authSession.accessToken)
        }
    }
}

extension PlayerViewController: SPTAudioStreamingDelegate {
    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
        // after a user authenticates a session, the SPTAudioStreamingController is then initialized and this method called
        print("logged in")
        self.player?.playSpotifyURI("spotify:track:7BHEi0cFs6TVNFDvbBrAjz", startingWith: 0, startingWithPosition: 0, callback: { (error) in
            if (error != nil) {
                print("\(String(describing: error))")
            }
        })
    }
}

extension PlayerViewController: SPTAudioStreamingPlaybackDelegate {
    func audioStreaming(_ audioStreaming: SPTAudioStreamingController!, didStartPlayingTrack trackUri: String!) {
        print("Started \(trackUri)")
    }
}
