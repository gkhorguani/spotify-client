//
//  PlayerViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 8/6/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

class PlaybackViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PlaybackViewController: SPTAudioStreamingDelegate {
    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
        // after a user authenticates a session, the SPTAudioStreamingController is then initialized and this method called
        // print("logged in")
    }
}

// MARK: - Playback management

extension PlaybackViewController: SPTAudioStreamingPlaybackDelegate {
    func audioStreaming(_ audioStreaming: SPTAudioStreamingController!, didStartPlayingTrack trackUri: String!) {
        print("Started \(trackUri) default playback delegate")
    }
}
