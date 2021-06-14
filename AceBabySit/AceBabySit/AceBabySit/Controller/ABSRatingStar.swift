//
//  ABSRatingStar.swift
//  AceBabySit
//
//  Created by Devron Tombacco on 20/09/2020.
//  Copyright © 2020 dtomswift. All rights reserved.
//

import UIKit

class ABSRatingStar: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureRatingStar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String){
        super.init(frame: .zero)
        configureRatingStar()
    }
    
    func configureRatingStar() {
        translatesAutoresizingMaskIntoConstraints = false
        self.image = UIImage(systemName: "star.fill")
        tintColor = .systemYellow
    }

}
