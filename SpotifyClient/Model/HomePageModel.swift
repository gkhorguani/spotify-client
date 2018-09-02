//
//  HomePageModel.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 8/11/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

class HomePageModel {
    let sptAuthUtils: SpotifyAuthUtils?
    
    init(sptAuthUtils: SpotifyAuthUtils) {
        self.sptAuthUtils = sptAuthUtils
    }
    
    func fetchFeaturedPlaylists(limit: Int, completion: @escaping ([FeaturedPlaylistItem]?) -> Void) {
        let authToken = sptAuthUtils?.readAuthToken()
        do {
            let requestFactory = PerformSPRequest()
            let playlistsRequest : URLRequest = try SPTBrowse.createRequestForFeaturedPlaylists(
                                            inCountry: "US",
                                            limit: limit,
                                            offset: 0,
                                            locale: nil,
                                            timestamp: nil,
                                            accessToken: authToken?.accessToken)
            
            requestFactory.perform(request: playlistsRequest, completion: { (error, response, data) in
                // Success
                let playlistList: SPTFeaturedPlaylistList = try SPTFeaturedPlaylistList(from: data, with: response)
                let playlistItems = playlistList.items as? [SPTPartialPlaylist]
                var results: [FeaturedPlaylistItem]? = []
                
                for playlist: SPTPartialPlaylist in playlistItems! {
                    print(playlist.name)
                    
                    if let img: SPTImage = playlist.images.first as? SPTImage {
                        print("Img url \(img.imageURL)")
                    }
                    
                }
                
                results = playlistItems?.map({ playlist in
                    if let playlistFirstImage = playlist.images.first as? SPTImage {
                        return FeaturedPlaylistItem(name: playlist.name, imageUrl: playlistFirstImage.imageURL)
                    }
                    
                    return FeaturedPlaylistItem(name: playlist.name, imageUrl: nil)
                })
                
                completion(results)
                
            }, onError: { error in
                // Failure
                print(error)
            })
        } catch {
            print(error)
        }
    }
    
}

struct FeaturedPlaylistItem {
    var name: String
    var imageUrl: URL?
}
