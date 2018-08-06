//
//  SignInViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/31/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

protocol SpotifyLoginViewDelegate {
    func loginSuccessfull()
}

class SignInViewController: UIViewController {
    @IBOutlet weak var singInButton: UIButton!
    
    var spotifyAuthUtils: SpotifyAuthUtils?
    var player: SPTAudioStreamingController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewDelegate = self
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .blue
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        spotifyAuthUtils = SpotifyAuthUtils()
        spotifyAuthUtils?.didMount()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SignInViewController: SpotifyLoginViewDelegate {
    func loginSuccessfull() {
        let userDefaults = UserDefaults.standard
        if let sessionObj:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            print(firstTimeSession)
            
            initializePlayer(authSession: firstTimeSession)
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

extension SignInViewController: SPTAudioStreamingDelegate {
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

extension SignInViewController: SPTAudioStreamingPlaybackDelegate {
    func audioStreaming(_ audioStreaming: SPTAudioStreamingController!, didStartPlayingTrack trackUri: String!) {
        print("Started \(trackUri)")
    }
}
