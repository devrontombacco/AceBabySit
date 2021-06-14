//
//  ReviewTableViewCell.swift
//  AceBabySit
//
//  Created by Devron Tombacco on 20/09/2020.
//  Copyright © 2020 dtomswift. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    let parentNameLabel: UILabel = {
        let parentNameLabel = UILabel()
        parentNameLabel.translatesAutoresizingMaskIntoConstraints = false
        parentNameLabel.textColor = K.Color.appPurple
        parentNameLabel.font = .systemFont(ofSize: 18, weight: .black)
        return parentNameLabel
    }()
    
    let parentReviewLabel: UILabel = {
        let parentReviewLabel = UILabel()
        parentReviewLabel.translatesAutoresizingMaskIntoConstraints = false
        parentReviewLabel.textColor = K.Color.appPink
        parentReviewLabel.font = .systemFont(ofSize: 15, weight: .medium)
        parentReviewLabel.numberOfLines = 0
        return parentReviewLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "ReviewTableViewCell")
        contentView.backgroundColor = .white
        contentView.addSubview(parentNameLabel)
        contentView.addSubview(parentReviewLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(modelData: reviewForBabySitter){
        parentNameLabel.text = modelData.nameOfParent
        parentReviewLabel.text = modelData.reviewOfParent
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        parentNameLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 5).isActive = true
        parentNameLabel.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor, constant: 5).isActive = true
        parentReviewLabel.topAnchor.constraint(equalTo: parentNameLabel.layoutMarginsGuide.bottomAnchor, constant: 10).isActive = true
        parentReviewLabel.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor, constant: 5).isActive = true
    }

}
