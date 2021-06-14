//
//  SitterActivityVC.swift
//  AceBabySit
//
//  Created by Devron Tombacco on 21/09/2020.
//  Copyright © 2020 dtomswift. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth

struct bookedSit {
    var nameOfParent: String
    var dateOfSit: String
}

struct endedSit {
    var parentName: String
    var dateSit: String
}

class SitterActivityVC: UIViewController {

    // MARK:- Variables
    
    var upcomingSitParentName = String()
    var upcomingSitDate = String()
    
    var completedSitParentName = String()
    var completedSitDate = String()
    
    var upcomingSits: DocumentReference!
    var completedSits: DocumentReference!
    
    let upcomingSitsLabel = ABSSectionHeading()
    var upcomingSitsTableView = UITableView()
    var upcomingSitsArray: [bookedSit] = []
    let completedSitsLabel = ABSSectionHeading()
    var completedSitsTableView = UITableView()
    var completedSitsArray: [endedSit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: K.Color.appPink]
        view.backgroundColor = K.Color.appBackgoundColor
        title = "Activity"
        configureUI()
        upcomingSits = Firestore.firestore().document("upcomingSit/futureSit")
        completedSits = Firestore.firestore().document("completedSit/finishedSit")
        fetchUpcomingSits()
        fetchCompletedSits()
    }
    
    // MARK:- UI Configuration Methods
    
    func configureUI(){
        configureUpcomingSitsLabel()
        configureUpcomingSitsTableView()
        configureCompletedSitsLabel()
        configureCompletedSitsTableView()
    }
    
    func configureUpcomingSitsLabel(){
        view.addSubview(upcomingSitsLabel)
        upcomingSitsLabel.translatesAutoresizingMaskIntoConstraints = false
        upcomingSitsLabel.text = "Upcoming Sits"
        
        NSLayoutConstraint.activate([
            upcomingSitsLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 40),
            upcomingSitsLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
        ])
    }
    
    // MARK:- UpcomingSitsTableView UI configuration Methods
    func configureUpcomingSitsTableView(){
        view.addSubview(upcomingSitsTableView)
        upcomingSitsTableView.register(UpcomingSitsTableViewCell.self, forCellReuseIdentifier: "UpcomingSitsTableViewCell")
            
        setTableViewDelegatesUpcomingSitsTableView()
        upcomingSitsTableView.rowHeight = 40
        upcomingSitsTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            upcomingSitsTableView.topAnchor.constraint(equalTo: upcomingSitsLabel.layoutMarginsGuide.bottomAnchor, constant: 20),
            upcomingSitsTableView.heightAnchor.constraint(equalToConstant: 200),
            upcomingSitsTableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            upcomingSitsTableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])

    }
    
    func fetchUpcomingSits(){
        upcomingSits.getDocument { (docSnapshot, error) in
            guard let docSnapshot = docSnapshot, docSnapshot.exists else { return }
            let upcomingSitData = docSnapshot.data()
            print(upcomingSitData)
            self.upcomingSitParentName = String(upcomingSitData?["parentName"] as? String ?? "")
            self.upcomingSitDate = String(upcomingSitData?["sitDate"] as? String ?? "")
            let nextSit = bookedSit(nameOfParent: self.upcomingSitParentName, dateOfSit: self.upcomingSitDate)
            self.upcomingSitsArray.append(nextSit)
            DispatchQueue.main.async {
                self.upcomingSitsTableView.reloadData()
            }
        }
    }
    
    func fetchCompletedSits() {
        completedSits.getDocument { (docSnapshot, error) in
            guard let docSnapshot = docSnapshot, docSnapshot.exists else { return }
            let completedSitData = docSnapshot.data()
            print(completedSitData)
            self.completedSitParentName = String(completedSitData?["parentName"] as? String ?? "")
            self.completedSitDate = String(completedSitData?["dateSit"] as? String ?? "")
            let previousSit = endedSit(parentName: self.completedSitParentName, dateSit: self.completedSitDate)
            self.completedSitsArray.append(previousSit)
            DispatchQueue.main.async {
                self.completedSitsTableView.reloadData()
            }
        }
    }
    
    // MARK:- UpcomingSitsTableView Delegate and DataSource
    
    func setTableViewDelegatesUpcomingSitsTableView(){
        upcomingSitsTableView.delegate = self
        upcomingSitsTableView.dataSource = self
    }

    func configureCompletedSitsLabel(){
        view.addSubview(completedSitsLabel)
        completedSitsLabel.translatesAutoresizingMaskIntoConstraints = false
        completedSitsLabel.text = "Completed Sits"

        NSLayoutConstraint.activate([
            completedSitsLabel.topAnchor.constraint(equalTo: upcomingSitsLabel.layoutMarginsGuide.bottomAnchor, constant: 300),
            completedSitsLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        ])
        
    }
    
    // MARK:- CompletedSits TableView UI Configuration Methods
    
    func configureCompletedSitsTableView(){
        view.addSubview(completedSitsTableView)
        completedSitsTableView.register(CompletedSitsTableViewCell.self, forCellReuseIdentifier: "CompletedSitsTableViewCell")
            
        setTableViewDelegatesCompletedSitsTableView()
        
        completedSitsTableView.rowHeight = 40
        completedSitsTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
        completedSitsTableView.topAnchor.constraint(equalTo: completedSitsLabel.layoutMarginsGuide.bottomAnchor, constant: 20),
        completedSitsTableView.heightAnchor.constraint(equalToConstant: 200),
        completedSitsTableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
        completedSitsTableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
        
    func setTableViewDelegatesCompletedSitsTableView(){
        completedSitsTableView.delegate = self
        completedSitsTableView.dataSource = self
    }
}

extension SitterActivityVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == upcomingSitsTableView {
            return upcomingSitsArray.count
        } else {
            return completedSitsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == upcomingSitsTableView {
            
            guard let cell = upcomingSitsTableView.dequeueReusableCell(withIdentifier: "UpcomingSitsTableViewCell", for: indexPath) as? UpcomingSitsTableViewCell else { return UITableViewCell() }
            
            let model = upcomingSitsArray[indexPath.row]
            cell.configureCell(modelData: model)
            
            return cell
            
        } else {
            
            guard let cell = completedSitsTableView.dequeueReusableCell(withIdentifier: "CompletedSitsTableViewCell", for: indexPath) as? CompletedSitsTableViewCell else { return UITableViewCell() }
            
            let model = completedSitsArray[indexPath.row]
            cell.configureCell(modelData: model)
        
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
