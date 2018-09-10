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
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    var playlistNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 16.0)
        
        return label
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
        playlistNameLabel.text = cellVM?.name
    }
    
    func render() {
        addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        
        addSubview(playlistNameLabel)
        playlistNameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(contentView)
            make.bottom.equalTo(imageView).offset(25)
        }
    }
}
