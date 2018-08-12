//
//  PlaylistsViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/28/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

class PlaylistsViewController: UIViewController, SideMenuable {
    weak var sideMenuDelegate: SideMenuViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("PLAYLISTS VC!!!")
        
        // overwrite the delegate
        PlayerSingleton.sharedInstance.player?.playbackDelegate = self
        
        // play Tash Sultana - Salvation
        PlayerSingleton.sharedInstance.player?.playSpotifyURI("spotify:track:4va2tNNWYut7ycFZ2zjvTk", startingWith: 0, startingWithPosition: 0, callback: nil)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "test", style: .done, target: self, action: #selector(onMenuTapped))
    }
    
    @objc func onMenuTapped() {
        print("Menu tapped!!!!!!!!")
        sideMenuDelegate?.toggleSideMenu()
    }
    
    func getNavigationStack() -> UINavigationController? {
        return navigationController
    }

}

extension PlaylistsViewController: SPTAudioStreamingPlaybackDelegate {
    func audioStreaming(_ audioStreaming: SPTAudioStreamingController!, didStartPlayingTrack trackUri: String!) {
        print("Started \(trackUri) on my newly implemented delegate")
    }
}
