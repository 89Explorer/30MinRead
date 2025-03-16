//
//  SettingScheduleViewController.swift
//  30MinRead
//
//  Created by 권정근 on 3/15/25.
//

import UIKit

class SettingScheduleViewController: UIViewController {
    
    // MARK: - Variables
    private let colorArray: [UIColor] = [.red, .blue, .yellow, .green, .orange, .purple, .cyan]
    
    
    // MARK: - UI Components
    private var saveButton: UIButton = UIButton(type: .system)
    private var colorCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var optionTableView: UITableView = UITableView(frame: .zero, style: .grouped)
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
    
        didTappedSaveButton()
        
        colorCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        
        
        optionTableView.delegate = self
        optionTableView.dataSource = self
        optionTableView.register(SettingScheduleCell.self, forCellReuseIdentifier: SettingScheduleCell.reuseIdentifier)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 60)
        colorCollectionView.collectionViewLayout = layout
    }
    
    
    // MARK: - Function
    private func didTappedSaveButton() {
        saveButton.addTarget(self, action: #selector(saveSchedule), for: .touchUpInside)
    }
    
    
    private func showDatePicker() -> Date {
        let alert = UIAlertController(title: "시청한 날짜", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        
        var selectedDate: Date = Date()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.frame = CGRect(x: 10, y: 30, width: alert.view.bounds.width - 20, height: 200)
        alert.view.addSubview(datePicker)
        
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            selectedDate = datePicker.date
            print(datePicker.date)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        return selectedDate

    }
    
    
    private func showTimePicker() -> Int {
        print("showTimerPicker called")
        
        let alert = UIAlertController(title: "독서에 집중하실 시간을 선택해주세요", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        var selectedTime: Int = 0
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .countDownTimer
        timePicker.locale = Locale(identifier: "ko_KR")
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.frame = CGRect(x: 10, y: 30, width: alert.view.bounds.width - 20, height: 200)
        
        alert.view.addSubview(timePicker)
        
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            selectedTime = Int(timePicker.countDownDuration)
            print(selectedTime)
            
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        return selectedTime
    }
    
    
    
    // MARK: - Actions
    @objc private func saveSchedule() {
        dismiss(animated: true)
    }
    
    
    // MARK: - Layout
    private func setupUI() {
        
        colorCollectionView.backgroundColor = .clear
        colorCollectionView.showsHorizontalScrollIndicator = false
        colorCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(colorCollectionView)
        
        optionTableView.backgroundColor = .clear
        optionTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(optionTableView)
        
        saveButton.setTitle("저장하기", for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .black
        saveButton.layer.cornerRadius = 10
        saveButton.layer.masksToBounds = true
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            
            colorCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            colorCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            colorCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            colorCollectionView.heightAnchor.constraint(equalToConstant: 60),
            
            
            optionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            optionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            optionTableView.topAnchor.constraint(equalTo: colorCollectionView.bottomAnchor, constant: 20),
            optionTableView.heightAnchor.constraint(equalToConstant: 240),
            
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }
}


// MARK: - Extension
extension SettingScheduleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = colorArray[indexPath.row]
        cell.layer.cornerRadius = 30
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = colorArray[indexPath.row]
        saveButton.backgroundColor = selectedItem
    }
}


// MARK: - Extension
extension SettingScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingScheduleCell.reuseIdentifier, for: indexPath) as? SettingScheduleCell else { return UITableViewCell()}
        
        let section = Section.allCases[indexPath.row]
        
        cell.configure(title: section.title, placeholder: section.placeholder)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = Section.allCases[indexPath.row]
        
        switch section {
        case .book:
            print("book 눌림")
        case .date:
            let selectedDate = showDatePicker()
            print("선택한 날짜: \(selectedDate)")
        case .time:
            let selectedTiem = showTimePicker()
            print("선택한 시간: \(selectedTiem)")
        }
    }
    
}

enum Section: CaseIterable {
    case book
    case date
    case time
    
    var title: String {
        switch self {
        case .book: return "책 선택"
        case .date: return "기간선택"
        case .time: return "시간선택"
        }
    }
    
    var placeholder: String {
        switch self {
        case .book: return "책 제목을 입력하세요"
        case .date: return "날짜를 선택하세요"
        case .time: return "시간을 선택하세요"
        }
    }
}
