//
//  Router.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 7/28/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

protocol AppRouter {
    associatedtype Parameter
    
    var routeParams: [String: Parameter] { get }
    
    func setParmeters(_ parameters: Parameter...)
}

class Router<T>: AppRouter {
    var routeParams = Dictionary<String, T>()
    
    // Inspired by javascript function args..
    // Could be better
    func setParmeters(_ parameters: T...) {
        for(index, parameter) in parameters.enumerated() {
            let key = "arg\(index)"
            routeParams[key] = parameter
        }
    }
}
