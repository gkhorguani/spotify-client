//
//  FeaturedPlaylistsCell.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 8/26/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

class FeaturedPlaylistsCell: UICollectionViewCell {
    var cellVM: FeaturedPlaylistCellViewModel?
    
    var imageView: UIImageView = {
        var iv = UIImageView()
        iv.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupBindings()
        render()
        
    }
    
    func setupBindings() {
        imageView.imageFromURL(urlString: cellVM?.imageURL?.absoluteString ?? "")
    }
    
    func render() {
        addSubview(imageView)
    }
}
