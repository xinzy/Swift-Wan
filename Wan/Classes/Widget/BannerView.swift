//
//  BannerView.swift
//  Wan
//
//  Created by Yang on 2020/4/22.
//  Copyright © 2020 Xinzy. All rights reserved.
//

protocol BannerViewDelete {
    func bannerView(_ bannerView: BannerView, tapIndex: Int, tapBanner: Banner)
}

class BannerView: UIView {

    private var mScrollView: UIScrollView = UIScrollView()
    private var mPageControl: UIPageControl = UIPageControl()
    
    private var mBanners: [Banner] = [Banner]()
    private var currentDisplayIndex: Int {
        let x = self.mScrollView.contentOffset.x
        if x >= width * CGFloat(mBanners.count) {
            return mBanners.count - 1
        } else if x <= 0 {
            return 0
        } else {
            return Int((x + width / 2) / width)
        }
    }
    
    private var mTimer: DispatchSourceTimer? = nil
    
    var delegate: BannerViewDelete? = nil
    
    deinit {
        if let timer = mTimer, !timer.isCancelled {
            timer.cancel()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        
        mScrollView.frame = self.bounds
        mScrollView.scrollsToTop = true
        mScrollView.isPagingEnabled = true
        mScrollView.isUserInteractionEnabled = true
        mScrollView.showsHorizontalScrollIndicator = false
        mScrollView.showsVerticalScrollIndicator = false
        addSubview(mScrollView)
        
        mPageControl.frame = CGRect(x: width / 2 - 30, y: height - 20, width: 60, height: 20)
        mPageControl.pageIndicatorTintColor = UIColor(fromHexString: "#E0E0E0")
        mPageControl.currentPageIndicatorTintColor = .red
        addSubview(mPageControl)
        
        mScrollView.delegate = self
    }
    
    
    func refreshBanner(banners: Array<Banner>?) {
        guard let list = banners else { return }
        guard !list.isEmpty else { return }
        if let timer = mTimer {
            timer.cancel()
        }
        
        mBanners.removeAll()
        mBanners += list
        
        if !mScrollView.subviews.isEmpty {
            for subview in mScrollView.subviews {
                subview.removeFromSuperview()
            }
        }
        
        let count = mBanners.count
        if count > 0 {
            mPageControl.isHidden = false
            mPageControl.numberOfPages = count
        } else {
            mPageControl.isHidden = true
            mPageControl.numberOfPages = 1
        }
        mPageControl.currentPage = 0
        
        mScrollView.contentSize = CGSize(width: width * CGFloat(count), height: height)
        
        for (index, item) in mBanners.enumerated() {
            
            let imageView = UIImageView(frame: CGRect(x: width * CGFloat(index), y: 0, width: width, height: height))
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.kf.setImage(with: URL(string: item.imagePath))
            
            imageView.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onItemImageTap))
            imageView.addGestureRecognizer(tapGestureRecognizer)
            
            mScrollView.addSubview(imageView)
        }
        
        mScrollView.contentOffset = CGPoint(x: 0, y: 0)
        setupTimer()
    }
    
    private func setupTimer() {
        mTimer = DispatchSource.makeTimerSource()
//        mTimer?.schedule(wallDeadline: .now(), repeating: .seconds(3), leeway: .seconds(3))
        mTimer?.schedule(wallDeadline: .now(), repeating: 3.0)
        mTimer?.setEventHandler {
            DispatchQueue.main.async {
                self.scrollToNext()
            }
        }
        mTimer?.resume()
    }
    
    private func scrollToNext() {
        var index = currentDisplayIndex + 1
        if index >= mBanners.count {
            index = 0
        }
        mScrollView.setContentOffset(CGPoint(x: width * CGFloat(index), y: 0), animated: true)
    }
    
    @objc private func onItemImageTap(_ imageView: UIImageView) {
        let index = currentDisplayIndex
        delegate?.bannerView(self, tapIndex: index, tapBanner: mBanners[index])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BannerView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        mPageControl.currentPage = currentDisplayIndex
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        mTimer?.suspend()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if mBanners.isEmpty {
            mTimer?.resume()
        }
    }
}

