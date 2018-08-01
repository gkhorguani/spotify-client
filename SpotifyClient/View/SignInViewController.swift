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
        }
    }
}
