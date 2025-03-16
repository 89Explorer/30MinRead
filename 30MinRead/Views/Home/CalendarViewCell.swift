//
//  CalendarViewCell.swift
//  30MinRead
//
//  Created by 권정근 on 3/16/25.
//

import UIKit

class CalendarViewCell: UITableViewCell {
    
    
    // MARK: - Variables
    static let reuseIdentifier: String = "CalendarViewCell"
    
    
    // MARK: - UI Componnets
    private let calendarView: UICalendarView = UICalendarView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray3
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Functions
    private func setupUI() {
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.fontDesign = .default
        calendarView.backgroundColor = .clear
        
        let today = Date()
        let todayComponents = gregorianCalendar.dateComponents([.year, .month, .day], from: today)
        
        calendarView.visibleDateComponents = todayComponents
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(calendarView)
        NSLayoutConstraint.activate([
            
            calendarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            calendarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            calendarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            calendarView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
            
        ])
    }
}
