//
//  HomePageViewModel.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 8/11/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

class HomePageViewModel {
    var homePageModel = HomePageModel(sptAuthUtils: SpotifyAuthUtils())
    var viewDelegate: HomePageViewModelDelegate?
    var featuredPlaylsits: [FeaturedPlaylistItem] = []
    var newReleases: [NewReleaseItem] = []
    
    func getFeaturedPlaylists(limit: Int = 10) {
        
        homePageModel.fetchFeaturedPlaylists(limit: limit) { (result: [FeaturedPlaylistItem]?) -> () in
            if let response = result {
                self.featuredPlaylsits = response
                self.viewDelegate?.featuredPlaylistsFetched()
            }
        }
    }
    
    func getNewReleases(limit: Int = 10) {
        homePageModel.fetchNewReleases(limit: limit) { (result: [NewReleaseItem]?) -> () in
            if let response = result {
                self.newReleases = response
                self.viewDelegate?.newReleasesFetched()
            }
        }
    }
}

protocol HomePageViewModelDelegate {
    func featuredPlaylistsFetched()
    func newReleasesFetched()
}
