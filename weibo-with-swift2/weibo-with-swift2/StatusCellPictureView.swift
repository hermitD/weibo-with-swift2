//
//  StatusCellPictureView.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/11.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit
import SDWebImage

private let StatusPictureItemWidth: CGFloat = 90
private let StatusPictureItemMargin: CGFloat = 10
private let StatusPictureCellID = "StatusPictureCellID"

class StatusCellPictureView: UICollectionView {
    var viewModel: StatusViewModel? {
        didSet {
            sizeToFit()
            reloadData()
        }
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        return calcViewSize()
    }
    
    //calculate view size via thumbnailUrls
    private func calcViewSize() -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: StatusPictureItemWidth, height: StatusPictureItemWidth)
        
        let rowCount = 3
        let count = viewModel?.thumbnailUrls?.count ?? 0
        
        if count == 0 {
            return CGSizeZero
        }
        
        if count == 1 {
            var size = CGSize(width: 150, height: 150)
            let key = viewModel!.thumbnailUrls![0].absoluteString
            
            // if have cache caculate
            if let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key) {
                size = image.size
            }
            
            size.width = size.width < 40 ? 40 : size.width
            if size.width > 300 {
                let w: CGFloat = 150
                let h = size.height * w / size.width
                size = CGSize(width: w, height: h)
            }
            
            layout.itemSize = size
            return size
        }
        
        if count == 4 {
            let w = 2 * StatusPictureItemWidth + StatusPictureItemMargin
            
            return CGSize(width: w, height: w)
        }
        
        let row = CGFloat((count - 1) / rowCount + 1)
        let w = CGFloat(rowCount) * StatusPictureItemWidth + CGFloat(rowCount - 1) * StatusPictureItemMargin
        let h = row * StatusPictureItemWidth + (row - 1) * StatusPictureItemMargin
        return CGSize(width: w, height: h)
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: StatusPictureItemWidth, height: StatusPictureItemWidth)
        layout.minimumInteritemSpacing = StatusPictureItemMargin
        layout.minimumLineSpacing = StatusPictureItemMargin
        
        super.init(frame: CGRectZero, collectionViewLayout: layout)
        
        backgroundColor = UIColor.lightGrayColor()
        dataSource = self

        registerClass(StatusPictureCell.self, forCellWithReuseIdentifier: StatusPictureCellID)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// dataSource
extension StatusCellPictureView: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // for those options use ??
        return viewModel?.thumbnailUrls?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(StatusPictureCellID, forIndexPath: indexPath) as! StatusPictureCell
        
        cell.imageUrl = viewModel!.thumbnailUrls![indexPath.item]
        
        return cell
    }
}

private class StatusPictureCell: UICollectionViewCell {
    
    var imageUrl: NSURL? {
        didSet {
            iconView.sd_setImageWithURL(imageUrl)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(iconView)
        
        iconView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView.snp_edges)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var iconView: UIImageView = {
        
        let iv = UIImageView()
        
        iv.contentMode = UIViewContentMode.ScaleAspectFill
        iv.clipsToBounds = true
        
        return iv
        }()
}
