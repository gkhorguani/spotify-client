//
//  PerformSPRequest.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 8/12/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

class PerformSPRequest {
    func perform(request: URLRequest, completion: @escaping (Error?, URLResponse?, Data?) throws -> Void, onError: @escaping (Error) -> Void) {
        DispatchQueue.global(qos: .background).async {
            SPTRequest.sharedHandler().perform(request) { (error, response, data) in
                do {
                    try completion(error, response, data)
                } catch {
                    onError(error)
                }
            }
            
            DispatchQueue.main.async {
                // Move to main if need be
            }
        }

    }
}
