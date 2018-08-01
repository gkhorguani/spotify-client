//
//  MenuRouteDelegate.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/29/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

protocol MenuRoutable {
    var menuRouteDelegate: MenuRouteDelegate? {get set}
}

protocol MenuRouteDelegate: class {
    func goToPlaylists()
}
