//
//  ABSSectionHeading.swift
//  AceBabySit
//
//  Created by Devron Tombacco on 17/09/2020.
//  Copyright © 2020 dtomswift. All rights reserved.
//

import UIKit

class ABSSectionHeading: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(text: String){
        super.init(frame: .zero)
        self.text = text
        configureLabel()
    }
    
    func configureLabel() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = K.Color.appPurple
        backgroundColor = K.Color.appBackgoundColor
        self.font = .systemFont(ofSize: 20, weight: .regular)
    }
}
