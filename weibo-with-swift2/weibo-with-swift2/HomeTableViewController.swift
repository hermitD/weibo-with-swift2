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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let useraccountVM = UserAccountViewModel()
        print(UserAccountViewModel.sharedAccountViewModel.userAccount)
        
        
        if let visterView = visitorView {
            visterView.setupInfo(nil, title: "hello")
        }
        //startAnim()
        
        //self.view.backgroundColor = UIColor.redColor()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }



}
