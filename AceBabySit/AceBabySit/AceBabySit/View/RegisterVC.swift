//
//  RegisterVC.swift
//  AceBabySit
//
//  Created by Devron Tombacco on 15/09/2020.
//  Copyright © 2020 dtomswift. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterVC: UIViewController, UITextFieldDelegate, TabBarPresentable  {

    // MARK:- Variables
    
    let descriptionLabel = UILabel()
    let emailTextField = ABSTextField(text: "Email")
    let passwordTextField = ABSTextField(text: "Password")
    let registerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Register"
        view.backgroundColor = K.Color.appBackgoundColor
        emailTextField.delegate = self
        passwordTextField.delegate = self
        configureUI()
    }
    // MARK:- UI Configuration Methods
    
    func configureUI() {
        configureDescriptionLabel()
        configureEmailTextField()
        configurePasswordTextField()
        configureRegisterButton()
    }
    
    func configureDescriptionLabel(){
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Insert email and password"
        descriptionLabel.textColor = K.Color.appPink
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 40),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 66),
        ])
        
    }
    
    // MARK:- TextField UI Methods
    
    func configureEmailTextField(){
        view.addSubview(emailTextField)
        emailTextField.placeholder = "Email"
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: descriptionLabel.layoutMarginsGuide.topAnchor, constant: 100),
            emailTextField.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 66),
            emailTextField.widthAnchor.constraint(equalToConstant: 288)
        ])
    }
    
    func configurePasswordTextField(){
        view.addSubview(passwordTextField)
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true 
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.layoutMarginsGuide.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 66),
            passwordTextField.widthAnchor.constraint(equalToConstant: 288)
        ])
    }

    // MARK:- TextField Delegate Methods
    
    // Dismiss keyboard when press return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Force user to insert valid input
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type Something..."
            return false
        }
    }
    
    // Allow to deselect textField
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.endEditing(true)
    }


    
    // MARK:- Button Methods
    
    func configureRegisterButton(){
        view.addSubview(registerButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.backgroundColor = K.Color.appPink
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 12
        
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: passwordTextField.layoutMarginsGuide.bottomAnchor, constant: 50),
            registerButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.widthAnchor.constraint(equalToConstant: 288)
        ])
        
        registerButton.addTarget(self, action: #selector(RegisterUser), for: .touchUpInside)
    }
    
    // MARK:- User Authentication Method
    
    @objc func RegisterUser(){
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    self.presentTabBarController()
                }
            }
        }
    }
}
