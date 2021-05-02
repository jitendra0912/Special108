//
//  PageCollectionViewCell.swift
//  JAPageSlider
//
//  Created by Jitendra on 02/05/21.
//

import UIKit

class PageCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String = "PageCollectionViewCell"
    private var image: UIImage?

        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = UIColor.clear
            setImageConstant()
            
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    lazy var screenImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
       //imageView.contentMode = .scaleAspectFit
        return imageView

    }()

    private func setImageConstant() {
        self.addSubview(screenImageView)
        NSLayoutConstraint.activate([
            screenImageView.topAnchor.constraint(equalTo: self.topAnchor),
            screenImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            screenImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            screenImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
    }
    
    func setDate(model:PagerModel) {
        screenImageView.image = model.image
        
    }
       
    
}
