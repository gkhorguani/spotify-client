//
//  LatestReleaseCell.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 9/11/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

class LatestReleaseCell: UITableViewCell {
    var cellVM: LatestReleaseCellViewModel?
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        
        return label
    }()
    
    var coverImage: UIImageView = {
        var iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        coverImage.sd_setImage(with: cellVM?.imageURL, completed: nil)
        nameLabel.text = cellVM?.name
    }
    
    func render() {
        contentView.addSubview(coverImage)
        coverImage.frame = CGRect(x: 0, y: 0, width: 80, height: 80)

        coverImage.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(20)
            make.centerY.equalTo(contentView)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(coverImage.snp.right).offset(20)
            make.top.bottom.equalTo(contentView)
        }
        
    }

}
