//
//  Coordinator.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/28/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

protocol Coordinator: class {
    associatedtype Parameter
    
    func start(_ router: Router<Parameter>?)
}

protocol SideMenuViewDelegate: class {
    func toggleSideMenu()
}

protocol SideMenuable {
    var sideMenuDelegate: SideMenuViewDelegate? {get set}
}
