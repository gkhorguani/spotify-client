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
    
}

extension SignInViewController: SpotifyLoginViewDelegate {
    func loginSuccessfull() {
        performSegue(withIdentifier: "showMainScene", sender: nil)
    }
}
