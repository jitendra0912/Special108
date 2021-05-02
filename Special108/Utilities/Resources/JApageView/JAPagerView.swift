//
//  JAPagerView.swift
//  JAPageSlider
//
//  Created by Jitendra on 02/05/21.
//

import UIKit

class JAPagerView: UIView {
    
    private var collectionView: UICollectionView!
    private var pageControl: UIPageControl!
    private var data : [PagerModel]?
    private var cellReuseIdentifier = "PageCollectionViewCell"
    private var timer = Timer()
    private var counter = 0
    
    // MARK: - Overriden functions
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = UIColor.clear
           
        }
        
        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            self.backgroundColor = UIColor.clear
        }
    open var isAutoScroll: Bool = false {
        didSet {
            self.startAutoScroll()
        }
    }
    
    public func loadPagerView(model:[PagerModel]) {
        self.data = model
        self.setupCollectionView()
    }
    private func startAutoScroll() {
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.autoChangeImage), userInfo: nil, repeats: true)
        }
    }
    @objc private func autoChangeImage() {
        if counter < data?.count ?? 0 {
         let index = IndexPath.init(item: counter, section: 0)
         self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
         pageControl.currentPage = counter
         counter += 1
     } else {
         counter = 0
         let index = IndexPath.init(item: counter, section: 0)
         self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
         pageControl.currentPage = counter
         counter = 1
     }
}
    
    // MARK:- Intinal setup
    private func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        flowLayout.scrollDirection = .horizontal
        self.addSubview(collectionView)
      NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        
        self.collectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: PageCollectionViewCell.identifier)
        self.collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        self.setPageControl()
        
    }
    private func setPageControl() {
        pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            
            pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 0),
            pageControl.widthAnchor.constraint(equalToConstant: CGFloat(Int(data?.count ?? 0) * 50 )),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: self.collectionView.centerXAnchor)
        ])
        
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.pageControl.numberOfPages = data?.count ?? 0
        self.pageControl.currentPage = 0
        pageControl.isHidden = !(data?.count ?? 0 > 1)
        self.pageControl.pageIndicatorTintColor = UIColor.gray
    }
}
extension JAPagerView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! PageCollectionViewCell
        guard let items = data else {
            return UICollectionViewCell()
        }
        
      
        cell.setDate(model: items[indexPath.row])
        return cell
    }
}

extension JAPagerView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

