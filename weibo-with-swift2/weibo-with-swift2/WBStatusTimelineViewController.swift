//
//  MessageTableViewController.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/7.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

import UIKit

class WBStatusTimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //lazy var listViewModel = StatusListViewModel()
    var tableView: UITableView!
    var layouts :[WBStatusLayout] = []
//    var statuses: [WBStatus] = []
//    lazy var listViewModel = StatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 1.000, alpha: 0.919)
        
        tableView = UITableView(frame: self.view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clearColor()
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        tableView.delaysContentTouches = false
        tableView.canCancelContentTouches = true
        tableView.separatorStyle = .None
        self.view.addSubview(self.tableView)
        
        self.navigationController?.view.userInteractionEnabled = false
        let indicator = UIActivityIndicatorView()
        indicator.size = CGSizeMake(80, 80)
        indicator.center = CGPointMake(self.view.width / 2, self.view.height / 2)
        indicator.backgroundColor = UIColor(white: 0.000, alpha: 0.670)
        indicator.clipsToBounds = true
        indicator.layer.cornerRadius = 6
        indicator.startAnimating()
        self.view.addSubview(indicator)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            
//            NetworkTools.sharedTools.loadStatus(0, max_id: 0, finished: { (result, error) -> () in
//                
//                if error != nil {
//                    return
//                }
//                //print(result)
//                if let data = result {
//                    let item = WBTimelineItem(data: data)
//                    for status in (item?.statusItems)! {
//                        //let layout = WBStatusLayout(status: status)
//                        status.layout = WBStatusLayout(status: status)
//                        status.layout!.layout()
//                        self.statuses.append(status)
//                        //self.layouts.append(status.layout!)
//                    }
//                }
////                print("over")
//                
////                guard let array = result?["statuses"] as? [[String: AnyObject]] else {
////                    completion(array: nil, error: NSError(domain: "cn.doyere.error", code: 300, userInfo: ["message": "dataformat error"]))
////                    return
////                }
////                
////                StatusDAL.saveStatusData(array)
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    self.title = "首页"
//                    indicator.removeFromSuperview()
//                    self.navigationController?.view.userInteractionEnabled = true
//                    self.tableView.reloadData()
//                })
//            })
//        })
    
            for i in 0..<8 {
                let data = NSData(named: "weibo_\(i).json")
                let item = WBTimelineItem(data: data)
                for status in (item?.statusItems)! {
                    let layout = WBStatusLayout(status: status)
                    layout!.layout()
                    self.layouts.append(layout!)
                }
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.title = "首页"
                indicator.removeFromSuperview()
                self.navigationController?.view.userInteractionEnabled = true
                self.tableView.reloadData()
            })

        
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("---layout.count ",self.layouts.count)
        return self.layouts.count
//        return self.statuses.count
        
    }
    
    let cellID: String = "cell"
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? WBStatusCell
        if cell == nil {
            cell = WBStatusCell(style: .Default, reuseIdentifier: cellID)
        }
        cell!.setLayout(self.layouts[indexPath.row])
//        cell?.setLayout(self.statuses[indexPath.row].layout!)
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (self.layouts[indexPath.row] as WBStatusLayout).height
//        return self.statuses[indexPath.row].layout!.height
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
}
