//
//  SignInViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/31/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    var clientId = ""
    let callbackUrl = URL(string: "SpotifyClient://returnAfterLogin")
    var loginUrl: URL?

    @IBOutlet weak var singInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default
            .addObserver(self, selector: #selector(SignInViewController.updateAfterFirstLogin), name: Notification.Name("loginSuccessfull"), object: nil)
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .blue
    }
    
    @objc func updateAfterFirstLogin () {
        let userDefaults = UserDefaults.standard
        if let sessionObj:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            print(firstTimeSession)
//            self.session = firstTimeSession
//            initializePlayer(authSession: session)
        }
    }

    @IBAction func signInTapped(_ sender: Any) {
        // Try to read the env var
        if let env_var_client_id = ProcessInfo.processInfo.environment["spotifyClientId"] {
            
            clientId = env_var_client_id
            let auth = SPTAuth.defaultInstance()
            auth?.clientID = clientId
            auth?.redirectURL = callbackUrl
            auth?.requestedScopes = [SPTAuthStreamingScope]
            
            loginUrl = auth?.spotifyWebAuthenticationURL()
            
            UIApplication.shared.open(loginUrl!, options: [:]) { (result) in
                // open page callback?
            }
        } else {
            print("Could not read the environment variable - client id")
        }
        
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
