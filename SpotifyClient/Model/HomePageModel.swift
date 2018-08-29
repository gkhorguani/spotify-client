//
//  HomePageModel.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 8/11/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import RxSwift

class HomePageModel {
    let sptAuthUtils: SpotifyAuthUtils?
    
    init(sptAuthUtils: SpotifyAuthUtils) {
        self.sptAuthUtils = sptAuthUtils
    }
    
    func fetchFeaturedPlaylists(completion: @escaping ([String]) -> Void) {
        let authToken = sptAuthUtils?.readAuthToken()
        do {
            let requestFactory = PerformSPRequest()
            let playlistsRequest : URLRequest = try SPTBrowse.createRequestForFeaturedPlaylists(
                                            inCountry: "US",
                                            limit: 5,
                                            offset: 0,
                                            locale: nil,
                                            timestamp: nil,
                                            accessToken: authToken?.accessToken)
            
            requestFactory.perform(request: playlistsRequest, completion: { (error, response, data) in
                // Success
                let playlistList: SPTFeaturedPlaylistList = try SPTFeaturedPlaylistList(from: data, with: response)
                let playlistItems = playlistList.items as? [SPTPartialPlaylist]
                print(playlistList.message)
                
                for playlist: SPTPartialPlaylist in playlistItems! {
                    print(playlist.name)
                    
                    if let img: SPTImage = playlist.images.first as? SPTImage {
                        print("Img url \(img.imageURL)")
                    }
                    
                }
                
                completion(["Test", "Test2"])
            }, onError: { error in
                // Failure
                print(error)
            })
        } catch {
            print(error)
        }
    }
    
    func getPlaylists() -> Observable<[SPTPartialPlaylist]?> {
        return Observable.create({ [weak self] (observer) -> Disposable in
            
            let authToken = self?.sptAuthUtils?.readAuthToken()
            do {
                let requestFactory = PerformSPRequest()
                let playlistsRequest : URLRequest = try SPTBrowse.createRequestForFeaturedPlaylists(
                    inCountry: "US",
                    limit: 5,
                    offset: 0,
                    locale: nil,
                    timestamp: nil,
                    accessToken: authToken?.accessToken)
                
                requestFactory.perform(request: playlistsRequest, completion: { (error, response, data) in
                    // Success
                    let playlistList: SPTFeaturedPlaylistList = try SPTFeaturedPlaylistList(from: data, with: response)
                    let playlistItems = playlistList.items as? [SPTPartialPlaylist]
                    
                    observer.onNext(playlistItems)
                }, onError: { error in
                    // Failure
                    observer.onError(error)
                })
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create {
                
            }
        })
    }
    
}
