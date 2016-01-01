//
//  StatusViewModel.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/10.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

class StatusViewModel: CustomStringConvertible {
    var status: Status
    
    lazy var rowHeigth: CGFloat = {
        var cell: StatusCell
        if self.status.retweeted_status != nil {
            //Status retweet cell
            cell = StatusRetweetedCell()
        }else {
            cell = StatusNormalCell()
            //normal cell
        }
        return cell.rowHeight(self)
        //return cell.rowHeight(self)
    }()
    
    var cellId: String {
        return self.status.retweeted_status == nil ? DYHomeNormalCellID: DYHomeRetweetedCellID// normalcell or retweetcell
    }
    
    var createAt: String {
        if let date = NSDate.sinaDate(status.created_at ?? "") {
            return date.dateDescription
        }
        return ""
    }
    
    var userProfileUrl: NSURL {
        return NSURL(string: status.user?.profile_image_url ?? "")!
    }
    
    var userVipImage: UIImage? {
        switch status.user?.verified_type ?? -1 {
        case 0: return UIImage(named: "avatar_vip")
        case 2, 3, 5: return UIImage(named: "avatar_enterprise_vip")
        case 220: return UIImage(named: "avatar_grassroot")
        default: return nil
        }
    }
    
    var userMemberImage: UIImage? {
        if status.user?.mbrank > 0 && status.user?.mbrank < 7 {
            return UIImage(named: "common_icon_membership_level\(status.user!.mbrank)")
        }
        return nil
    }
    
    var thumbnailUrls: [NSURL]?
    var retweetedText: String? {
        let userName = status.retweeted_status?.user?.screen_name ?? ""
        let text = status.retweeted_status?.text ?? ""
        return "@" + userName + ":" + text
    }
    
    init(status: Status) {
        self.status = status
        
        //general thumbnail [pic]
        if let urls = status.retweeted_status?.pic_urls ?? status.pic_urls {
            thumbnailUrls = [NSURL]()
            for dict in urls {
                let url = NSURL(string: dict["thumbnail_pic"] ?? "")
                thumbnailUrls?.append(url!)
            }
        }
    }
    
    var description: String {
        return status.description + "[pic] \(thumbnailUrls)"
    }
}