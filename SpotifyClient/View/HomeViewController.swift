//
//  HomeViewController.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/28/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, LayoutProvider, SideMenuable {
    weak var sideMenuDelegate: SideMenuViewDelegate?
    var homeCoordinator: HomeCoordinator?
    var homePageVM = HomePageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        render()
        
        homePageVM.getFeaturedPlaylists {
            print("Feched the playlists..")
        }
        
    }
    
    func setupUI() {
        self.setupLayout()
    }
    
    @IBAction func onMenuTapped() {
        print("Menu tapped")
        sideMenuDelegate?.toggleSideMenu()
    }
    
    func getNavigationStack() -> UINavigationController? {
        return navigationController
    }
    
    func render() {
        let searchButton = UIButton()
        searchButton.setTitle("Go", for: .normal)
        searchButton.setTitleColor(.blue, for: .normal)
        searchButton.layer.cornerRadius = 25
        
        let searchTextBox = UITextField()
        searchTextBox.placeholder = "Search anything.."
        searchTextBox.backgroundColor = .white
        searchTextBox.layer.cornerRadius = 25
        searchTextBox.setLeftPaddingPoints(20)
        searchTextBox.rightView = searchButton
        searchTextBox.rightViewMode = .always
        view.addSubview(searchTextBox)
        
        searchButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
        }
        
        searchTextBox.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.leading.equalTo(view).offset(50)
            make.trailing.equalTo(view).offset(-50)
            make.top.equalTo(view).offset(50)
            make.centerX.equalTo(view)
        }
        
    }
    
}
