//
//  StatusCell.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/10.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit



class StatusCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    /// 根据视图模型计算行高
//    ///
//    /// - parameter vm: 视图模型
//    ///
//    /// - returns: 行高
//    func rowHeight(vm: StatusViewModel) -> CGFloat {
//        // 1. 设置视图模型
//        viewModel = vm
//        
//        // 2. 更新约束
//        layoutIfNeeded()
//        
//        // 3. 返回底部视图的最大 Y 值
//        return CGRectGetMaxY(bottomView.frame)
//    }
    
}