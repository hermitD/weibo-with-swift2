//
//  StatusCell.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/10.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit
import SnapKit
import FFLabel


let DYStatusCellIconWidth: CGFloat = 35
let DYStatusCellMargin: CGFloat = 12

protocol StatusCellDelegate: NSObjectProtocol {

    func statusCellDidClickLink(url: NSURL)
}

class StatusCell: UITableViewCell {
    
    weak var cellDelegate: StatusCellDelegate?
    
    var viewModel: StatusViewModel? {
        didSet {
            topView.viewModel = viewModel
            
            let statusText = viewModel?.status.text ?? ""
            //TODO raw string -> add emotion's
            contentLabel.text = statusText
            
            pictureView.viewModel = viewModel
        }
    }
    private lazy var topView: StatusCellTopView = StatusCellTopView()
    lazy var contentLabel: FFLabel = FFLabel(title: "Contents",
        color: UIColor.darkGrayColor(),
        fontSize: 15,
        layoutWidth: UIScreen.mainScreen().bounds.width - 2 * DYStatusCellMargin)

    lazy var pictureView: StatusCellPictureView = StatusCellPictureView()
    lazy var bottomView: StatusCellBottomView = StatusCellBottomView()
    
    func rowHeight(vm: StatusViewModel) -> CGFloat {
        viewModel = vm
        //4 update constrains
        layoutIfNeeded()
        return CGRectGetMaxY(bottomView.frame)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        setupUI()   
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = UIColor.whiteColor()
        
        contentView.addSubview(topView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(pictureView)
        contentView.addSubview(bottomView)
        
        topView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp_top)
            make.left.equalTo(contentView.snp_left)
            make.right.equalTo(contentView.snp_right)
            make.height.equalTo(2 * DYStatusCellMargin + DYStatusCellIconWidth)
        }
        
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(topView.snp_bottom).offset(DYStatusCellMargin)
            make.left.equalTo(contentView.snp_left).offset(DYStatusCellMargin)
        }
        
        bottomView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(pictureView.snp_bottom).offset(DYStatusCellMargin)
            make.left.equalTo(contentView.snp_left)
            make.right.equalTo(contentView.snp_right)
            make.height.equalTo(44)
            
            // make.bottom.equalTo(contentView.snp_bottom)
        }
        
        contentLabel.labelDelegate = self
    }
    
}

extension StatusCell: FFLabelDelegate {
    
    func labelDidSelectedLinkText(label: FFLabel, text: String) {
        
        if !text.hasPrefix("http://") {
            return
        }
        guard let url = NSURL(string: text) else {
            return
        }
        cellDelegate?.statusCellDidClickLink(url)
    }
}