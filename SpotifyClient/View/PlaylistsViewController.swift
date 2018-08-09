//
//  PlaylistsViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/28/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

class PlaylistsViewController: UIViewController {
    var player: SPTAudioStreamingController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("PLAYLISTS VC!!!")
        
        // overwrite the delegate
        
        self.player?.playbackDelegate = self
        
        // play Tash Sultana - Salvation
        self.player?.playSpotifyURI("spotify:track:4va2tNNWYut7ycFZ2zjvTk", startingWith: 0, startingWithPosition: 0, callback: nil)
    }

}

extension PlaylistsViewController: SPTAudioStreamingPlaybackDelegate {
    func audioStreaming(_ audioStreaming: SPTAudioStreamingController!, didStartPlayingTrack trackUri: String!) {
        print("Started \(trackUri) on my newly implemented delegate")
    }
}
