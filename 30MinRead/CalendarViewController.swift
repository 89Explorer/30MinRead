//
//  CalendarViewController.swift
//  30MinRead
//
//  Created by 권정근 on 3/13/25.
//

import UIKit

class CalendarViewController: UIViewController {
    
    
    private let calendarView: UICalendarView = UICalendarView()
    
    private let calendarDelegate = CalendarViewDelegate()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("지금 시간: ", Date())
        view.backgroundColor = .white
        
        let gregorianCalendar = Calendar.current // ✅ Calendar.current 사용
        calendarView.calendar = gregorianCalendar
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.fontDesign = .rounded
        
        let today = Date()
        let todayComponents = gregorianCalendar.dateComponents([.year, .month, .day], from: today)
        
        calendarView.visibleDateComponents = todayComponents
        
        calendarDelegate.calendarView = calendarView
        calendarView.delegate = calendarDelegate
        
        setupUI()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.addDynamicDecoration()
        }
    }
    
    
    private func setupUI() {
        view.addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.topAnchor.constraint(equalTo: view.topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
    }
    
    
    // ✅ 새로운 날짜에 동적으로 데코레이션 추가
    private func addDynamicDecoration() {
        
        let calendar = Calendar.current
        
        let newDateComponents = DateComponents(year: 2025, month: 3, day: 25)
        let newDate = calendar.date(from: newDateComponents)!
        
        let newDecoration = UICalendarView.Decoration.image(
            UIImage(systemName: "star.fill"),
            color: .blue,
            size: .large
        )
        
        calendarDelegate.add(decoration: newDecoration, on: newDate)
        print("✅ 3월 25일에 ⭐️ 추가 완료!")
    }
}


class CalendarViewDelegate: NSObject, UICalendarViewDelegate {
    
    weak var calendarView: UICalendarView?
    var decorations: [DateComponents: UICalendarView.Decoration] = [:] // ✅ Date 대신 DateComponents 사용
    
    override init() {
        super.init()
        setupDecorations()
    }
    
    private func setupDecorations() {
        let calendar = Calendar.current // ✅ Calendar.current를 사용하여 통일
        
        let specialDates: [(Int, Int, String)] = [
            (3, 17, "heart.fill"),
            (3, 19, "flame.fill")
        ]
        
        for (month, day, systemImage) in specialDates {
            var components = DateComponents(year: 2025, month: month, day: day) // ✅ DateComponents 생성 시 calendar 제외
            components.calendar = calendar  // ✅ 명확하게 같은 Calendar 사용
            
            let decoration = UICalendarView.Decoration.image(
                UIImage(systemName: systemImage),
                color: .red,
                size: .large
            )
            
            decorations[components] = decoration // ✅ Key를 DateComponents로 변경
        }
    }
    
    // ✅ 특정 날짜에 데코레이션 추가 (Date → DateComponents 변환)
    func add(decoration: UICalendarView.Decoration, on date: Date) {
        
        let calendar = Calendar.current // ✅ Calendar 통일
        var dateComponents = calendar.dateComponents(
            [.year, .month, .day],
            from: date
        )
        
        dateComponents.calendar = calendar  // ✅ 명확한 Calendar 설정

        decorations[dateComponents] = decoration // ✅ Key를 DateComponents로 저장

        
        DispatchQueue.main.async {
            
            if let calendarView = self.calendarView {
                print("🔄 캘린더 UI 업데이트 실행: \(dateComponents)")
                calendarView.reloadDecorations(forDateComponents: [dateComponents], animated: true)
                
            } else {
                print("❌ calendarView가 nil 상태입니다. 업데이트 실패")
            }
        }
    }
    
    
    // ✅ `calendarView(_:decorationFor:)`에서 `calendar` 속성을 제거하고 `year, month, day`만 비교
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        
        var queryComponents = DateComponents(
            year: dateComponents.year,
            month: dateComponents.month,
            day: dateComponents.day
        ) // ✅ `calendar` 속성 제거
        
        queryComponents.calendar = Calendar.current // ✅ 명확한 Calendar 설정
        
        return decorations[queryComponents]
    }
}

