//
//  BasicCell.swift
//  NaRogax
//
//  Created by User on 21/02/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

//
//  BasicCell.swift
//  MyPagerCollView
//
//  Created by Leela Prasad on 08/03/18.
//  Copyright © 2018 Leela Prasad. All rights reserved.
//
import UIKit

class BasicCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    var indicatorView: UIView!
    
    override var isSelected: Bool {
        didSet{
            UIView.animate(withDuration: 0.30) {
                self.indicatorView.backgroundColor = self.isSelected ? #colorLiteral(red: 1, green: 0.1098039216, blue: 0.1647058824, alpha: 1) : UIColor.clear
                self.layoutIfNeeded()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.textAlignment = .center
        titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addSubview(titleLabel)
        addConstraintsWithFormatString(formate: "H:|[v0]|", views: titleLabel)
        addConstraintsWithFormatString(formate: "V:|[v0]|", views: titleLabel)
        
        addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        setupIndicatorView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
    
    func setupIndicatorView() {
        indicatorView = UIView()
        addSubview(indicatorView)
        
        addConstraintsWithFormatString(formate: "H:|[v0]|", views: indicatorView)
        addConstraintsWithFormatString(formate: "V:[v0(3)]|", views: indicatorView)
    }
}
