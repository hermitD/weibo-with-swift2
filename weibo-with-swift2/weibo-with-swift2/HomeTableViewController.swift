//
//  HomeTableViewController.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/7.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit
import SDWebImage


class HomeTableViewController: DYBaseTableVC {
    lazy var listViewModel = StatusListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let useraccountVM = UserAccountViewModel()
        //print(UserAccountViewModel.sharedAccountViewModel.userAccount)
        if !UserAccountViewModel.sharedAccountViewModel.userLogon {
            visitorView?.setupInfo(nil, title: "hello")
            return
        }
        
        prepareaTableView()
        loadData()
        
//        if let visterView = visitorView {
//            visterView.setupInfo(nil, title: "hello")
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func prepareaTableView() {
        tableView.registerClass(StatusNormalCell.self, forCellReuseIdentifier: DYHomeNormalCellID)
        tableView.registerClass(StatusRetweetedCell.self, forCellReuseIdentifier: DYHomeRetweetedCellID)
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .None
        
        //pulldown and up controller
    }
    @objc private func loadData() {
        listViewModel.loadStatus(false) { (error) -> () in
            if error != nil {
                print("loadData failed with \(error)")
                return
            }
            
            print("get status!! \(self.listViewModel.statuses.count)")
            self.tableView.reloadData()
            
        }
    }
    
}

// Table view data source
extension HomeTableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statuses.count
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return listViewModel.statuses[indexPath.row].rowHeigth
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let vm = listViewModel.statuses[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(vm.cellId, forIndexPath: indexPath) as! StatusCell
        cell.viewModel = vm
        return cell
    }


    



}
