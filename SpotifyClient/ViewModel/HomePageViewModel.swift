//
//  HomePageViewModel.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 8/11/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

class HomePageViewModel {
    var homePageModel = HomePageModel(sptAuthUtils: SpotifyAuthUtils())
    
    func getFeaturedPlaylists(limit: Int = 5, completion: @escaping () -> Void) {
        homePageModel.fetchFeaturedPlaylists() { result in
//            print(result)
            completion()
        }
    }
}
