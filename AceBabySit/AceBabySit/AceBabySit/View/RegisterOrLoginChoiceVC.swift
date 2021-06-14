//
//  RegisterOrLoginChoiceVC.swift
//  AceBabySit
//
//  Created by Devron Tombacco on 12/09/2020.
//  Copyright © 2020 dtomswift. All rights reserved.
//

import UIKit

class RegisterOrLoginChoiceVC: UIViewController {

    // MARK:- Variables
    let AceBabySitLogo = UIImageView()
    let registerButton = ABSButton(title: "Register")
    let loginButton = ABSButton(title: "Login")

        
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = K.Color.appBackgoundColor
        configureUI()
    }
    
    // MARK:- UI Configuration Methods
    
    func configureUI(){
        configureLogoView()
        configureRegisterButton()
        configureLoginButton()
    }
    
    func configureLogoView(){
        view.addSubview(AceBabySitLogo)
        AceBabySitLogo.translatesAutoresizingMaskIntoConstraints = false
        AceBabySitLogo.image = UIImage(named: "AceBabySitLogo1")
        
        NSLayoutConstraint.activate([
            AceBabySitLogo.widthAnchor.constraint(equalToConstant: 199),
            AceBabySitLogo.heightAnchor.constraint(equalToConstant: 155),
            AceBabySitLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            AceBabySitLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK:- Button Methods
    
    func configureRegisterButton(){
        view.addSubview(registerButton)
        registerButton.backgroundColor = K.Color.appPink
        registerButton.setTitleColor(.white, for: .normal)

        NSLayoutConstraint.activate([
            registerButton.widthAnchor.constraint(equalToConstant: 288),
            registerButton.heightAnchor.constraint(equalToConstant: 66),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: AceBabySitLogo.bottomAnchor, constant: 109)
        ])
        
        registerButton.addTarget(self, action: #selector(goToRegisterVC), for: .touchUpInside)
    }
    
    @objc func goToRegisterVC(){
      navigationController?.pushViewController(RegisterVC(), animated: true)
    }

    func configureLoginButton(){
        view.addSubview(loginButton)
        loginButton.backgroundColor = K.Color.appYellow
        loginButton.setTitleColor(.white, for: .normal)
        
        NSLayoutConstraint.activate([
            loginButton.widthAnchor.constraint(equalToConstant: 288),
            loginButton.heightAnchor.constraint(equalToConstant: 66),
            loginButton.leadingAnchor.constraint(equalTo: registerButton.leadingAnchor),
            loginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20)
        ])
        
        loginButton.addTarget(self, action: #selector(goToLoginVC), for: .touchUpInside)
    }

    @objc func goToLoginVC(){
      navigationController?.pushViewController(LoginVC(), animated: true)
    }
    
}
