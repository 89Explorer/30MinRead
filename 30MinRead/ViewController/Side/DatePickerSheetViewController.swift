//
//  DatePickerSheetViewController.swift
//  30MinRead
//
//  Created by 권정근 on 3/17/25.
//

import UIKit

class DatePickerSheetViewController: UIViewController {
    
    // MARK: - Variable
    private var selectedStartDate: Date?
    private var selectedEndDate: Date?
    weak var delegate: DatePickerDelegate?
    
    // MARK: - UI Component
    private let calendarView: UICalendarView = UICalendarView()
    private let confirmButton: UIButton = UIButton(type: .system)
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    
    // MARK: - Function
    private func setupUI() {
        calendarView.selectionBehavior = UICalendarSelectionMultiDate(delegate: self)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        confirmButton.setTitle("선택 완료", for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        confirmButton.setTitleColor(.label, for: .normal)
        confirmButton.backgroundColor = .systemGreen
        confirmButton.layer.cornerRadius = 10
        confirmButton.layer.masksToBounds = true
        confirmButton.addTarget(self, action: #selector(confirmSelection), for: .touchUpInside)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false

        
        view.addSubview(calendarView)
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            calendarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            calendarView.heightAnchor.constraint(equalToConstant: 300),
            
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 15),
            confirmButton.heightAnchor.constraint(equalToConstant: 60)
            
        ])
        
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
    // MARK: - Actions
    @objc private func confirmSelection() {
        if let startDate = selectedStartDate,
           let endDate = selectedEndDate {
            delegate?.didSelectedDateRange(startDate: formatDate(startDate), endDate: formatDate(endDate))
            //print("선택한 기간: \(formatDate(startDate)) ~ \(formatDate(endDate))")
            dismiss(animated: true)
        } else {
            print("기간을 선택해주세요")
        }
    }

}


// MARK: - Extension: UICalendarSelectionMultiDateDelegate
extension DatePickerSheetViewController: UICalendarSelectionMultiDateDelegate {
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        guard let newDate = dateComponents.date else { return }

        if selectedStartDate == nil {
            selectedStartDate = newDate
            selectedEndDate = newDate
        } else if selectedEndDate == nil {
            if newDate < selectedStartDate! {
                selectedEndDate = selectedStartDate
                selectedStartDate = newDate
            } else {
                selectedEndDate = newDate
            }
        } else {
            // ✅ 세 번째 날짜 선택 시, 기존 시작일/종료일 중 더 가까운 날짜를 변경
            let allDates = [selectedStartDate!, selectedEndDate!, newDate].sorted() // ✅ 날짜 정렬
            selectedStartDate = allDates.first
            selectedEndDate = allDates.last
        }
        
        selectDatesBetween(selection: selection, startDate: selectedStartDate!, endDate: selectedEndDate!)
    }
    
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        guard let date = dateComponents.date else { return }

        if date == selectedStartDate {
            selectedStartDate = nil
        } else if date == selectedEndDate {
            selectedEndDate = nil
        }
    }
    
    // ✅ 시작일과 종료일 사이의 모든 날짜를 자동으로 선택하는 함수
    private func selectDatesBetween(selection: UICalendarSelectionMultiDate, startDate: Date, endDate: Date) {
        
        let calendar = Calendar.current
        var currentDate = startDate
        
        while currentDate <= endDate {
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
            selection.selectedDates.append(dateComponents) // ✅ 날짜 추가
            guard let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else { break }
            currentDate = nextDate
        }
    }
}


protocol DatePickerDelegate: AnyObject {
    func didSelectedDateRange(startDate: String, endDate: String)
}
