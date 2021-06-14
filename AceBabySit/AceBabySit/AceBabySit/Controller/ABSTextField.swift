//
//  ABSRegisterOrLoginTextField.swift
//  AceBabySit
//
//  Created by Devron Tombacco on 16/09/2020.
//  Copyright © 2020 dtomswift. All rights reserved.
//

import UIKit

class ABSTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        init(text: String){
        super.init(frame: .zero)
        configureTextField()
    }
    
    func configureTextField(){
        translatesAutoresizingMaskIntoConstraints = false
        textColor = K.Color.appPurple
        backgroundColor = .white
        layer.cornerRadius = 18
        textAlignment = .center
    }
}
