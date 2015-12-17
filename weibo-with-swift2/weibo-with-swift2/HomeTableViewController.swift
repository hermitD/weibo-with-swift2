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
    

    private lazy var pulldownTipLabel: UILabel = {
        let label = UILabel(title: "", color: UIColor.whiteColor(), fontSize: 18)
        label.backgroundColor = UIColor.orangeColor()
        
        self.navigationController?.navigationBar.insertSubview(label, atIndex: 0)
        
        return label
    }()
    private lazy var pullupView: UIActivityIndicatorView = {
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        indicator.color = UIColor.darkGrayColor()
        
        return indicator
    }()
    
    var titleButton:DYTitleButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !UserAccountViewModel.sharedAccountViewModel.userLogon {
            visitorView?.setupInfo(nil, title: "hello")
            return
        }

        //let useraccountVM = UserAccountViewModel()
        //print(UserAccountViewModel.sharedAccountViewModel.userAccount)
        
        setupNavVC()
        prepareaTableView()
        loadData()
        
//        if let visterView = visitorView {
//            visterView.setupInfo(nil, title: "hello")
//        }
        
    }
    
    private func setupNavVC() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendsearch", highImage: "navigationbar_friendsearch_highlighted", target: self, action: "friendsearch")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", highImage: "navigationbar_pop_highlighted", target: self, action: "pop")
        
        
        var titleButton = DYTitleButton()
        let title = UserAccountViewModel.sharedAccountViewModel.userAccount?.screen_name ?? "Main"
        titleButton.setTitle(title, forState: .Normal)
        titleButton.setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Normal)
        titleButton.setImage(UIImage(named: "navigationbar_arrow_down"), forState: .Selected)
        titleButton.addTarget(self, action: "titleClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.titleView = titleButton
        
    }
    
    private func prepareaTableView() {
        tableView.registerClass(StatusNormalCell.self, forCellReuseIdentifier: DYHomeNormalCellID)
        tableView.registerClass(StatusRetweetedCell.self, forCellReuseIdentifier: DYHomeRetweetedCellID)
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .None
        
        refreshControl = DYRefreshControl()
        refreshControl?.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
        tableView.tableFooterView = pullupView

        
        //pulldown and up controller
    }
    
    @objc private func titleClick(button: UIButton) {
        button.selected = !button.selected
        let cover = DYCover.show()
        cover.delegate = self
        
        let popW:CGFloat = 200
        let popX:CGFloat = (view.width() - 200) * 0.5
        let popH = popW
        let popY:CGFloat = 55
        let menu = DYPopMenu.showInRect(CGRectMake(popX, popY, popW, popH ))
        menu.contentView = UITableView()
        
    }
    
    @objc private func friendsearch() {
        print("friendsearch")
    }
    @objc private func pop() {
        print("pop")
        let theVC = UITableViewController()
        self.navigationController?.pushViewController(theVC, animated: true)
    }

    
    @objc private func loadData() {
        refreshControl?.beginRefreshing()
        
        listViewModel.loadStatus(pullupView.isAnimating()) { (error) -> () in
            self.refreshControl?.endRefreshing()
            self.pullupView.stopAnimating()
            
            if error != nil {
                print("loadData failed with \(error)")
                return
            }
            
            
            print("get status!! \(self.listViewModel.statuses.count)")
            self.showPullDownTip()
            
            self.tableView.reloadData()
            
        }
    }
    
    private func showPullDownTip() {
        guard let count = listViewModel.pulldownCount else{
            print("not Pull Down")
            return
        }
        let title = count == 0 ? "Nothing New" : "get \(count) new status"
        pulldownTipLabel.text = title
        
        let h: CGFloat = 44
        //KNOW  iOS NavBar/ToolBar/TabBar can't use constrians
        let rect = CGRect(x: 0, y: -2 * h, width: view.bounds.width, height: h)
        pulldownTipLabel.frame = rect
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.pulldownTipLabel.frame = CGRectOffset(rect, 0, 3 * h)
            }) { (_) -> Void in
                UIView.animateWithDuration(1.0) { self.pulldownTipLabel.frame = rect }
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
        
        if indexPath.row == listViewModel.statuses.count - 1 && !pullupView.isAnimating() {
            pullupView.startAnimating()
            loadData()
        }
        return cell
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let theVC = UITableViewController()
//        self.presentViewController(theVC, animated: true, completion: nil)
//    }

}

extension HomeTableViewController: DYCoverDelegate {
    func coverdidClicked(cover: DYCover) {
        DYPopMenu.hide()
        titleButton?.selected = false
    }
}
