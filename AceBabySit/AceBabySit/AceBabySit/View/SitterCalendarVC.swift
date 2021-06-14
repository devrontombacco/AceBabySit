//
//  SitterCalendarVC.swift
//  AceBabySit
//
//  Created by Devron Tombacco on 21/09/2020.
//  Copyright © 2020 dtomswift. All rights reserved.
//

import UIKit
import FSCalendar

class SitterCalendarVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance  {
    
    // MARK:- Variables
    
    var calendar = FSCalendar()
    var formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: K.Color.appPink]
        view.backgroundColor = K.Color.appBackgoundColor
        title = "Calendar"
        
        configureCalendar()
        
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    // MARK:- Configure Calendar Methods
    
    func configureCalendar(){
        view.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant:40),
            calendar.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            calendar.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            calendar.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        calendar.scrollDirection = .horizontal
        calendar.appearance.headerTitleFont =  .systemFont(ofSize: 20, weight: .medium)
        calendar.appearance.headerTitleColor = K.Color.appPurple
        calendar.appearance.titleFont = .systemFont(ofSize: 17, weight: .medium)
        calendar.appearance.todayColor = K.Color.appPink
        calendar.appearance.titleTodayColor = K.Color.appPurple
        calendar.appearance.weekdayTextColor = .black
        calendar.appearance.selectionColor = K.Color.appYellow
        
        // Enable selection of several days
        calendar.allowsMultipleSelection = true

    }

    // MARK:- Calendar DataSource

    //showing events as a dot
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        formatter.dateFormat = "dd-MM-yyyy"
        guard let eventDate = formatter.date(from: "22-07-2020") else {return 0}
        if date.compare(eventDate) == .orderedSame {
            return 2
        }
        return 0
    }
    
    //MARK:- Calendar Delegate
    
    // User can select date in calendar using this method. Returns date as String!
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd-MM-yyyy"
        print("Date selected == \(formatter.string(from: date))")
    }
        
    // make a date unselectable
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
           formatter.dateFormat = "dd-MM-yyyy"
            guard let excludedDate = formatter.date(from: "23-07-2020") else { return true }
            if date.compare(excludedDate) == .orderedSame {
                return false
            }
            
            return true
        }
    
    // MARK: - Calendar DelegateAppearance
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        formatter.dateFormat = "dd-MM-yyyy"
            guard let excludedDate = formatter.date(from: "23-07-2020") else {return nil}
            if date.compare(excludedDate) == .orderedSame {
            return .orange
            }
        return nil
    }
    
}
