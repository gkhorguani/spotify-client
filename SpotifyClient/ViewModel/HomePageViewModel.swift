//
//  HomePageViewModel.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 8/11/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import RxSwift

class HomePageViewModel {
    var homePageModel = HomePageModel(sptAuthUtils: SpotifyAuthUtils())
    var disposeBag = DisposeBag()
    
    func getFeaturedPlaylists(limit: Int = 5, completion: @escaping () -> Void) {
        homePageModel.getPlaylists().subscribe(onNext: { (response) in
            guard let result = response else {
                return
            }
            
            for playlist: SPTPartialPlaylist in result {
                print(playlist.name)
                
                if let img: SPTImage = playlist.images.first as? SPTImage {
                    print("Img url \(img.imageURL)")
                }
                
            }
        }).disposed(by: disposeBag)
        
    }
}
