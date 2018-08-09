//
//  PlayerViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 8/6/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

class PlaybackViewController: UIViewController {
    var player: SPTAudioStreamingController?
    var spotifyAuthUtils: SpotifyAuthUtils?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension PlaybackViewController: SPTAudioStreamingDelegate {
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

// MARK: - Playback management

extension PlaybackViewController: SPTAudioStreamingPlaybackDelegate {
    func audioStreaming(_ audioStreaming: SPTAudioStreamingController!, didStartPlayingTrack trackUri: String!) {
        print("Started \(trackUri)")
    }
}
