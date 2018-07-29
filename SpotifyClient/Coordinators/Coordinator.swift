//
//  Coordinator.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/28/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    associatedtype Parameter
    
    func start(_ router: Router<Parameter>?)
}

protocol SideMenuViewDelegate: class {
    func toggleSideMenu()
    func getNavigationStack() -> UINavigationController?
}

protocol SideMenuable {
    var sideMenuDelegate: SideMenuViewDelegate? {get set}
    
    // Any VC which supports side menu, should also return the reference to navigation controller
    func getNavigationStack() -> UINavigationController?
}
