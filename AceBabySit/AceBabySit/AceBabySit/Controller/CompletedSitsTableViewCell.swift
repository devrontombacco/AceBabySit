//
//  CompletedSitsTableViewCell.swift
//  AceBabySit
//
//  Created by Devron Tombacco on 21/09/2020.
//  Copyright © 2020 dtomswift. All rights reserved.
//

import UIKit

class CompletedSitsTableViewCell: UITableViewCell {

    let parentNameLabel: UILabel = {
        let parentNameLabel = UILabel()
        parentNameLabel.translatesAutoresizingMaskIntoConstraints = false
        parentNameLabel.textColor = K.Color.appPurple
        parentNameLabel.font = .systemFont(ofSize: 18, weight: .black)
        return parentNameLabel
    }()
    
    let dateOfSitLabel: UILabel = {
        let dateOfSitLabel = UILabel()
        dateOfSitLabel.translatesAutoresizingMaskIntoConstraints = false
        dateOfSitLabel.textColor = K.Color.appPink
        dateOfSitLabel.font = .systemFont(ofSize: 15, weight: .medium)
        return dateOfSitLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "UpComingSitsTableViewCell")
        contentView.backgroundColor = .white
        contentView.addSubview(parentNameLabel)
        contentView.addSubview(dateOfSitLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(modelData: endedSit){
        parentNameLabel.text = modelData.parentName
        dateOfSitLabel.text = modelData.dateSit
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        parentNameLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 5).isActive = true
        parentNameLabel.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor, constant: 5).isActive = true
        dateOfSitLabel.topAnchor.constraint(equalTo: parentNameLabel.layoutMarginsGuide.bottomAnchor, constant: 10).isActive = true
        dateOfSitLabel.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor, constant: 5).isActive = true
    }

}
