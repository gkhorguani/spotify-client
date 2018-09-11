//
//  LatestReleaseCell.swift
//  SpotifyClient
//
//  Created by Giorgi Khorguani on 9/11/18.
//  Copyright © 2018 Giorgi Khorguani. All rights reserved.
//

import UIKit

class LatestReleaseCell: UITableViewCell {
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        
        return label
    }()
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(self.contentView).offset(20)
            make.centerY.equalTo(self.contentView)
        }
        
    }

}
