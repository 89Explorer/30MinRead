//
//  ScheduleViewController.swift
//  30MinRead
//
//  Created by 권정근 on 3/14/25.
//

import UIKit

class ScheduleViewController: UIViewController {

    // MARK: - UI Components
    private let calendarView: UICalendarView = UICalendarView()
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let button: UIButton = UIButton(type: .system)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        
        collectionView.register(ScheduleCell.self, forCellWithReuseIdentifier: ScheduleCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        didTappedAddScheduleButton()
        
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: collectionView.bounds.width, height: 250) 
        collectionView.collectionViewLayout = layout
    }
    
    // MARK: - Layout
    private func setupUI() {
        
        let gregorianCalendar = Calendar.current // ✅ Calendar.current 사용
        calendarView.calendar = gregorianCalendar
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.fontDesign = .rounded
        
        let today = Date()
        let todayComponents = gregorianCalendar.dateComponents([.year, .month, .day], from: today)
        
        calendarView.visibleDateComponents = todayComponents
        
        view.addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("일정 생성", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        button.tintColor = .label
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.heightAnchor.constraint(equalToConstant: 400),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 20),
            collectionView.heightAnchor.constraint(equalToConstant: 250),
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}


extension ScheduleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCell.reuseIdentifier, for: indexPath) as? ScheduleCell else {
            return UICollectionViewCell() // 만약 캐스팅 실패 시 기본 셀 반환
        }
        
        cell.configure(image: "book", title: "교육의 뇌과학", date: "3월 14일" + " ~ " + "3월 24일", time: "매일 30분", check: "✅ ✅ ✅ ✅")
        return cell
    
    }
}


// Extension: "일정 생성 버튼"
extension ScheduleViewController {
    
    func didTappedAddScheduleButton() {
        button.addTarget(self, action: #selector(addSchedule), for: .touchUpInside)
    }
    
    @objc private func addSchedule() {
        print("addSchedule - called")
        showScheduleSettingView()
    }
    
    func showScheduleSettingView() {
        print("showScheduleSettingView - open")
        let settingVC = SettingScheduleViewController()
        
        if let sheet = settingVC.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 25
            sheet.detents = [.medium(), .large()]
            
        }
        
        present(settingVC, animated: true)
    }
}

