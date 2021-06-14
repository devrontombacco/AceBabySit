//
//  LoginVC.swift
//  AceBabySit
//
//  Created by Devron Tombacco on 16/09/2020.
//  Copyright © 2020 dtomswift. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


    // MARK:- TabBarPresentable Protocol
protocol TabBarPresentable: UIViewController {
    func presentTabBarController()
}

class LoginVC: UIViewController, TabBarPresentable {

    // MARK:- Variables
    
    let descriptionLabel = UILabel()
    let emailTextField = ABSTextField(text: "Email")
    let passwordTextField = ABSTextField(text: "Password")
    let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Login"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: K.Color.appPink]
        view.backgroundColor = K.Color.appBackgoundColor
        configureUI()
    }
    
    // MARK:- UI Configuration Methods
    
    func configureUI(){
        configureDescriptionLabel()
        configureEmailTextField()
        configurePasswordTextField()
        configureLoginButton()
    }
    
    func configureDescriptionLabel(){
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Insert login information"
        descriptionLabel.textColor = K.Color.appPink
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 40),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 66),
        ])
    }
    
    // MARK:- TextField Methods
    
    func configureEmailTextField(){
        view.addSubview(emailTextField)
        emailTextField.placeholder = "Email"
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: descriptionLabel.layoutMarginsGuide.bottomAnchor, constant: 70),
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
    
    // MARK:- LoginButton Methods
    
    func configureLoginButton(){
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = K.Color.appYellow
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 12
            
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.layoutMarginsGuide.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalToConstant: 288)
        ])
        
        loginButton.addTarget(self, action: #selector(goToSitterProfileVC), for: .touchUpInside)
        }
    
    // MARK:- Authenticate User
    
    @objc func goToSitterProfileVC(){
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
              guard let self = self else { return }
                if let e = error {
                    print(e)
                } else {
                    self.presentTabBarController()
                }
            }
        }
    }
}
    // MARK:- PresentTabBar Method

extension TabBarPresentable {
    func presentTabBarController() {
        let tabBar = UITabBarController()

        let profileVC = UINavigationController(rootViewController: SitterProfileVC())
        profileVC.title = "Profile"
        let activityVC = UINavigationController(rootViewController: SitterActivityVC())
        activityVC.title = "Activity"
        let calendarVC = UINavigationController(rootViewController: SitterCalendarVC())
        calendarVC.title = "Calendar"
        
        tabBar.setViewControllers([profileVC, activityVC, calendarVC], animated: false)
        
        guard let items = tabBar.tabBar.items else { return }
        
        let images = ["person", "plus.square", "calendar"]
        
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }
        
        UITabBar.appearance().tintColor = K.Color.appPurple
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
}
