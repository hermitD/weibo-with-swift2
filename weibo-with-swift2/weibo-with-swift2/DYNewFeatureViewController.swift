//
//  DYNewFeatureViewController.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/9.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit
import SnapKit

private let newFeatureImageCount = 4
private let newFeaturReuseIdentifier = "NewFeature"

class DYNewFeatureViewController: UICollectionViewController {
    
    private lazy var pageControl = UIPageControl()
    //??? without override why??
    
     init() {
        let layout = UICollectionViewFlowLayout()
        
        //KNOW Rect vs BOUNDS  
        //The frame property contains the frame rectangle, which specifies the size and location of the view in its superview’s coordinate system.
        //The bounds property contains the bounds rectangle, which specifies the size of the view (and its content origin) in the view’s own local coordinate system.        
        layout.itemSize = UIScreen.mainScreen().bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        super.init(collectionViewLayout: layout)
        
        collectionView?.pagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces = false
    }
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.registerClass(NewFeatureCell.self, forCellWithReuseIdentifier: newFeaturReuseIdentifier)
   
        setupPageControl()
        //setup pagecontrol
    }
    private func setupPageControl() {
        pageControl.center = CGPointMake(self.view.center.x, self.view.bounds.height - 10)
        pageControl.numberOfPages = newFeatureImageCount
        pageControl.currentPageIndicatorTintColor = UIColor.blueColor()
        pageControl.pageIndicatorTintColor = UIColor.blackColor()
        self.view.addSubview(pageControl)
    }
    
}
// delegate and datasource methods
extension DYNewFeatureViewController {
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
        pageControl.currentPage = page
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newFeatureImageCount
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(newFeaturReuseIdentifier, forIndexPath: indexPath) as! NewFeatureCell
        
        cell.imageIndex = indexPath.item
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let _indexPath = collectionView.indexPathsForVisibleItems()[0]
        if _indexPath.item == (newFeatureImageCount - 1) {
            (collectionView.cellForItemAtIndexPath(_indexPath) as! NewFeatureCell).startButtonAnim()
        }
    }
}


private class NewFeatureCell: UICollectionViewCell{
    private lazy var iconView = UIImageView()
    private lazy var startButton: UIButton = UIButton(title: "Start:)", fontSize: 18, color: UIColor.whiteColor(), backImageName: "new_feature_finish_button")
    
    var imageIndex = 0 {
        didSet {
            iconView.image = UIImage(named: "new_feature_\(imageIndex + 1)")
            startButton.hidden = true
        }
    }
    
    @objc private func clickStartButton() {
        NSNotificationCenter.defaultCenter().postNotificationName(
            DYSwitchRootViewControllerNotification, object: nil)
    }
    
    private func startButtonAnim() {
        startButton.hidden = false
        startButton.transform = CGAffineTransformMakeScale(0, 0)
        startButton.userInteractionEnabled = false
        
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: [], animations: { () -> Void in
            self.startButton.transform = CGAffineTransformIdentity
            }) { (_) -> Void in
                self.startButton.userInteractionEnabled = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(iconView)
        contentView.addSubview(startButton)
        
        iconView.frame = self.bounds
        startButton.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(snp_centerX)
            make.bottom.equalTo(snp_bottom).offset(-150)
        }
        
        startButton.addTarget(self, action: "clickStartButton", forControlEvents: .TouchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}