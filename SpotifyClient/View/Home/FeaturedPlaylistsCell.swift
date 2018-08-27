//
//  FeaturedPlaylistsCell.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 8/26/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

class FeaturedPlaylistsCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .red
    }
}
