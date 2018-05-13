//
//  POCTableViewCell.swift
//  ProofOfConcept
//
//  Created by Shweta Shendage on 13/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import UIKit
import SnapKit

class POCTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let imageProfile = UIImageView()
    let descriptionLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.titleLabel.numberOfLines = 0
        self.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.titleLabel.textColor = UIColor.darkGray
        contentView.addSubview(self.titleLabel)
        
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.descriptionLabel.textColor = UIColor.lightGray
        contentView.addSubview(self.descriptionLabel)
        
        self.imageProfile.contentMode = .scaleAspectFit
        self.imageProfile.image = #imageLiteral(resourceName: "default-user-image")
        contentView.addSubview(self.imageProfile)

        let padding:UIEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        
        self.imageProfile.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(padding.top)
            make.left.equalTo(contentView).offset(padding.left)
            make.height.width.equalTo(100)
            make.bottom.lessThanOrEqualTo(-padding.bottom)
            
        }
        
        self.titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.imageProfile.snp.top)
            make.right.equalTo(contentView).offset(-padding.right)
            make.left.equalTo(self.imageProfile.snp.right).offset(padding.right)
        }
        
        self.descriptionLabel.snp.makeConstraints { (make) -> Void in
            
            make.top.equalTo(self.titleLabel.snp.bottom).offset(padding.bottom)
            make.right.equalTo(contentView).offset(-padding.right)
            make.left.equalTo(self.imageProfile.snp.right).offset(padding.right)
            make.bottom.lessThanOrEqualTo(-padding.bottom)
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
