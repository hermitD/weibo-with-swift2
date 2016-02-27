//
//  StatusNormalCell.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/10.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

class StatusNormalCell: StatusCell {
    override var viewModel: StatusViewModel? {
        didSet {
            pictureView.snp_updateConstraints { (make) -> Void in
                make.width.equalTo(pictureView.bounds.width)
                make.height.equalTo(pictureView.bounds.height)
                
                let offset = (pictureView.bounds.height == 0) ? 0 : DYStatusCellMargin
                make.top.equalTo(contentLabel.snp_bottom).offset(offset)
            }
        }
    }
    
    
    override func setupUI() {
        super.setupUI()
        
        pictureView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentLabel.snp_bottom).offset(DYStatusCellMargin)
            make.left.equalTo(contentLabel.snp_left)
            make.width.equalTo(290)
            make.height.equalTo(290)
        }
    }
}
