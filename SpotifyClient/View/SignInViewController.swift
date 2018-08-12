//
//  SignInViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/31/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit
import SnapKit

protocol SpotifyLoginViewDelegate {
    func loginSuccessfull()
}

class SignInViewController: UIViewController, LayoutProvider {
    var spotifyAuthUtils: SpotifyAuthUtils?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewDelegate = self
        
        setupUI()
        render()
    }
    
    @objc func signInTapped(_ sender: Any) {
        spotifyAuthUtils = SpotifyAuthUtils()
        spotifyAuthUtils?.didMount()
    }
    
    func setupUI() {
        setupLayout()
    }
    
    func render() {
        let playLogo = UIImage(named: "play_logo")!.withRenderingMode(.alwaysTemplate)
        let logoContainer = UIImageView(image: playLogo)
        logoContainer.tintColor = .white
        view.addSubview(logoContainer)
        
        logoContainer.snp.makeConstraints { (make) in
            make.width.height.equalTo(48)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(self.view)
        }
        
        let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        let gradient = CAGradientLayer()
        gradient.cornerRadius = 75
        
        gradient.frame = buttonView.bounds
        gradient.colors = [
            UIColor(red:0.38, green:0.13, blue:0.36, alpha:1.0),
            UIColor(red:0.73, green:0.18, blue:0.44, alpha:1.0)
            ].map({ $0.cgColor })
        
        buttonView.layer.insertSublayer(gradient, at: 0)
        view.addSubview(buttonView)
        
        buttonView.snp.makeConstraints { (make) in
            make.width.height.equalTo(150)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            make.centerX.equalTo(self.view)
        }
        
        let signinButton = UIButton()
        signinButton.setTitle("SIGN IN", for: .normal)
        signinButton.setTitleColor(.white, for: .normal)
        signinButton.addTarget(self, action: #selector(signInTapped(_:)), for: .touchUpInside)
        buttonView.addSubview(signinButton)
        signinButton.snp.makeConstraints { make in
            make.center.equalTo(buttonView)
        }
    }
    
}

extension SignInViewController: SpotifyLoginViewDelegate {
    func loginSuccessfull() {
        performSegue(withIdentifier: "showMainScene", sender: nil)
    }
}
