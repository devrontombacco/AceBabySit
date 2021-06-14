//
//  ABSButtonLight.swift
//  AceBabySit
//
//  Created by Devron Tombacco on 14/09/2020.
//  Copyright © 2020 dtomswift. All rights reserved.
//

import UIKit

class ABSButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String){
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        configure()
    }

    func configure() {
        layer.cornerRadius = 18
        titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        translatesAutoresizingMaskIntoConstraints = false
    }

}
