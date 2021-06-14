//
//  SitterProfileVC.swift
//  AceBabySit
//
//  Created by Devron Tombacco on 17/09/2020.
//  Copyright © 2020 dtomswift. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth

struct reviewForBabySitter {
    var nameOfParent: String
    var reviewOfParent: String
}

class SitterProfileVC: UIViewController {

    // MARK: - Variables
    var name = String()
    var review = String()
    
    var parentRev: DocumentReference!
    
    let personalInfoHeading = ABSSectionHeading()
    let ratingHeading = ABSSectionHeading()
    let reviewsHeading = ABSSectionHeading()
    let personalInfoView = UIView()
    let profileImage = UIImageView()
    let nameLabel = UILabel()
    let addressLabel = UILabel()
    let emailLabel = UILabel()
    let telephoneLabel = UILabel()
    let ratingStarStackView = UIStackView()
    var reviewTableView = UITableView()
    var reviewArray: [reviewForBabySitter] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: K.Color.appPink]
        view.backgroundColor = K.Color.appBackgoundColor
        title = "Profile"
        configureUI()
        parentRev = Firestore.firestore().document("reviewForSitter/parentReview")
        fetchReviews()
    }

    func fetchReviews(){
        parentRev.getDocument { (docSnapshot, error) in
            guard let docSnapshot = docSnapshot, docSnapshot.exists else { return }
            let reviewData = docSnapshot.data()
            print(reviewData)
            self.name = String(reviewData?["parentName"] as? String ?? "")
            self.review = String(reviewData?["parentReview"] as? String ?? "")
            let firstReview = reviewForBabySitter(nameOfParent: self.name, reviewOfParent: self.review)
            self.reviewArray.append(firstReview)
            DispatchQueue.main.async {
                self.reviewTableView.reloadData()
            }
        }
    }

    
    // MARK: - UI Configuration Methods

    func configureUI(){
        configurePersonalInfoHeading()
        configurePersonalInfoView()
        configureRatingHeading()
        configureReviewsHeading()
        configureRatingStarStackView()
        configureReviewTableView()
    }
    
    // MARK: - Personal Info UI Configuration Methods
    
    func configurePersonalInfoHeading(){
        view.addSubview(personalInfoHeading)
        personalInfoHeading.translatesAutoresizingMaskIntoConstraints = false
        personalInfoHeading.text = "Personal Information"
 
        NSLayoutConstraint.activate([
            personalInfoHeading.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 40),
            personalInfoHeading.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
        ])
    }
    
    func configurePersonalInfoView(){
        view.addSubview(personalInfoView)
        personalInfoView.translatesAutoresizingMaskIntoConstraints = false
        personalInfoView.backgroundColor = K.Color.appLightGray
        personalInfoView.backgroundColor = K.Color.appBackgoundColor

        NSLayoutConstraint.activate([
            personalInfoView.topAnchor.constraint(equalTo:personalInfoHeading.layoutMarginsGuide.bottomAnchor, constant: 20),
            personalInfoView.heightAnchor.constraint(equalToConstant: 100),
            personalInfoView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            personalInfoView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
            
        view.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.image = #imageLiteral(resourceName: "outdoors")
        profileImage.layer.cornerRadius = 80 / 2
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
            
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: personalInfoView.layoutMarginsGuide.topAnchor,constant: 5),
            profileImage.heightAnchor.constraint(equalToConstant: 80),
            profileImage.leadingAnchor.constraint(equalTo: personalInfoView.layoutMarginsGuide.leadingAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 80),
            
        ])
            
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Name Surname"
        nameLabel.textColor = K.Color.appPurple
        nameLabel.font = nameLabel.font.withSize(15)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: personalInfoView.layoutMarginsGuide.topAnchor, constant:10),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.layoutMarginsGuide.trailingAnchor,constant: 40),
        ])
            
        view.addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.text = "Address"
        addressLabel.textColor = K.Color.appPurple
        addressLabel.font = addressLabel.font.withSize(15)
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: nameLabel.layoutMarginsGuide.bottomAnchor, constant:10),
            addressLabel.leadingAnchor.constraint(equalTo: profileImage.layoutMarginsGuide.trailingAnchor,constant: 40)
        ])
        
        view.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.text = "example@email.com"
        emailLabel.textColor = K.Color.appPurple
        emailLabel.font = emailLabel.font.withSize(15)
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: addressLabel.layoutMarginsGuide.bottomAnchor, constant:10),
            emailLabel.leadingAnchor.constraint(equalTo: profileImage.layoutMarginsGuide.trailingAnchor,constant: 40)
        ])
        
        view.addSubview(telephoneLabel)
        telephoneLabel.translatesAutoresizingMaskIntoConstraints = false
        telephoneLabel.text = "+46 123.456.789"
        telephoneLabel.textColor = K.Color.appPurple
        telephoneLabel.font = telephoneLabel.font.withSize(15)
        
        NSLayoutConstraint.activate([
            telephoneLabel.topAnchor.constraint(equalTo: emailLabel.layoutMarginsGuide.bottomAnchor,constant: 10),
            telephoneLabel.leadingAnchor.constraint(equalTo: profileImage.layoutMarginsGuide.trailingAnchor,constant: 40)
        ])
        
    }
    
    // MARK: - Rating UI Configuration Methods
    
    func configureRatingHeading(){
        view.addSubview(ratingHeading)
        ratingHeading.translatesAutoresizingMaskIntoConstraints = false
        ratingHeading.text = "Rating"

        NSLayoutConstraint.activate([
            ratingHeading.topAnchor.constraint(equalTo: personalInfoHeading.layoutMarginsGuide.bottomAnchor, constant: 180),
          ratingHeading.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
        ])
    }
    
    func configureRatingStarStackView(){
        view.addSubview(ratingStarStackView)
        ratingStarStackView.translatesAutoresizingMaskIntoConstraints = false
        ratingStarStackView.axis = .horizontal
        ratingStarStackView.distribution = .fillEqually
        ratingStarStackView.spacing = 10
        
        NSLayoutConstraint.activate([
            ratingStarStackView.topAnchor.constraint(equalTo: ratingHeading.layoutMarginsGuide.bottomAnchor, constant: 20),
            ratingStarStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 52),
            ratingStarStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -52),
            ratingStarStackView.heightAnchor.constraint(equalToConstant: 40)
                ])
        
        addStarsToRatingStarStackView()
    }
    
    func addStarsToRatingStarStackView(){
        let numberOfStars = 5
        for _ in 1...numberOfStars {
            let star = ABSRatingStar(frame: CGRect())
            ratingStarStackView.addArrangedSubview(star)
        }
    }

    func configureReviewsHeading(){
        view.addSubview(reviewsHeading)
        reviewsHeading.translatesAutoresizingMaskIntoConstraints = false
        reviewsHeading.text = "Reviews Received"

        NSLayoutConstraint.activate([
            reviewsHeading.topAnchor.constraint(equalTo: ratingHeading.layoutMarginsGuide.bottomAnchor, constant: 120),
            reviewsHeading.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
        ])
    }
    
    func configureReviewTableView(){
        view.addSubview(reviewTableView)
        reviewTableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: "ReviewTableViewCell")
        
        setTableViewDelegates()
        reviewTableView.rowHeight = 50
        reviewTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            reviewTableView.topAnchor.constraint(equalTo: reviewsHeading.layoutMarginsGuide.bottomAnchor, constant: 20),
             reviewTableView.heightAnchor.constraint(equalToConstant: 200),
             reviewTableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
             reviewTableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
         ])

    }
    
    func setTableViewDelegates(){
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
    }
}

extension SitterProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
        
        let model = reviewArray[indexPath.row]
        cell.configureCell(modelData: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
