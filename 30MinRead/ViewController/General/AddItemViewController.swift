//
//  AddItemViewController.swift
//  30MinRead
//
//  Created by 권정근 on 3/17/25.
//

import UIKit

class AddItemViewController: UIViewController {
    
    // MARK: - Variable
    private var startDate: String?
    private var endDate: String?
    
    private var remainingSeconds: Int = 0
    
    // MARK: - UI Component
    private let titleLabel: UILabel = UILabel()
    private let pageLabel: UILabel = UILabel()
    private let dateLabel: UILabel = UILabel()
    private let timeLabel: UILabel = UILabel()
    
    private let titleTextField: UITextField = UITextField()
    private let pageTextField: UITextField = UITextField()
    private let dateTextField: UITextField = UITextField()
    private let timeTextField: UITextField = UITextField()
    
    private let stackView: UIStackView = UIStackView()
    
    private let saveButton: UIButton = UIButton(type: .system)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        
        navigationItem.title = "새 일정 작성"
        setupUI()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didMissed))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    
    // MARK: - Functions
    private func setupUI() {
        
        [titleLabel, pageLabel, dateLabel, timeLabel].forEach {
            $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            $0.textColor = .black
            $0.textAlignment = .left
        }
        
        [titleTextField, pageTextField, dateTextField, timeTextField].forEach {
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.leftViewMode = .always
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
            $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            $0.backgroundColor = .white
            $0.textColor = .darkGray
            $0.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
        
        titleLabel.text = "책 이름"
        pageLabel.text = "총 페이지"
        dateLabel.text = "기간"
        timeLabel.text = "시간"
        
        titleTextField.placeholder = "책 이름을 입력하세요"
        titleTextField.keyboardType = .default
        titleTextField.returnKeyType = .done
        
        pageTextField.placeholder = "전체 페이지수를 입력하세요"
        pageTextField.keyboardType = .numberPad
        pageTextField.returnKeyType = .done
        
        dateTextField.placeholder = "독서 기간을 선택하세요"
        dateTextField.delegate = self
        
        timeTextField.placeholder = "독서 시간을 입력하세요"
        timeTextField.delegate = self
        
        saveButton.setTitle("일정 저장", for: .normal)
        saveButton.tintColor = .black
        saveButton.backgroundColor = .systemOrange
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        saveButton.layer.cornerRadius = 10
        saveButton.layer.masksToBounds = true
        saveButton.addTarget(self, action: #selector(saveItem), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleStack = createRow(label: titleLabel, textField: titleTextField)
        let pageStack = createRow(label: pageLabel, textField: pageTextField)
        let dateStack = createRow(label: dateLabel, textField: dateTextField)
        let timeStack = createRow(label: timeLabel, textField: timeTextField)
        
        stackView.addArrangedSubview(titleStack)
        stackView.addArrangedSubview(pageStack)
        stackView.addArrangedSubview(dateStack)
        stackView.addArrangedSubview(timeStack)
        
        view.addSubview(stackView)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)

        ])
        
    }
    
    private func createRow(label: UILabel, textField: UITextField) -> UIStackView {
        let rowStack = UIStackView(arrangedSubviews: [label, textField])
        rowStack.axis = .vertical
        rowStack.spacing = 15
        //rowStack.alignment = .leading
        rowStack.distribution = .fill
        return rowStack
    }
    
    // MARK: - Action
    @objc private func didMissed() {
        view.endEditing(true)
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        self.remainingSeconds = Int(sender.countDownDuration)
    }
    
    @objc private func confirmSelection() {
        print("1일 독서 시간 확인")
        self.updateLabel()
        dismiss(animated: true)
    }
    
    @objc private func saveItem() {
        print("일정 저장")
        navigationController?.popViewController(animated: true)
    }
    
}


// MARK: - Extension: UITextFieldDelegate
extension AddItemViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == dateTextField {
            let datePickerVC = DatePickerSheetViewController()
            
            if let sheet = datePickerVC.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 20
            }
            datePickerVC.delegate = self
            present(datePickerVC, animated: true)
            return false
        } else  if textField == timeTextField {
            showDatePicker()
            return false
        }
        
        return true
    }
}


// Extension: - DatePickerDelegate: 날짜 선택
extension AddItemViewController: DatePickerDelegate {
    func didSelectedDateRange(startDate: String, endDate: String) {
        
        let dates = [startDate, endDate].sorted()
        
        self.startDate = dates.first
        self.endDate = dates.last
        
        dateTextField.text = "\(startDate) ~ \(endDate)"
    }
}


// Extension: - 매일 독서 시간 설정 관련 메서드
extension AddItemViewController {
    
    private func showDatePicker() {
        let datePickerVC = UIViewController()
        datePickerVC.view.backgroundColor = .systemBackground
        
        let titleLabel: UILabel = UILabel()
        titleLabel.text = "1일 독서 시간을 정해주세요:)"
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 24, weight: .black)
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        let confirmButton: UIButton = UIButton(type: .system)
        confirmButton.setTitle("선택 완료", for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        confirmButton.setTitleColor(.label, for: .normal)
        confirmButton.backgroundColor = .systemGreen
        confirmButton.layer.cornerRadius = 10
        confirmButton.layer.masksToBounds = true
        confirmButton.addTarget(self, action: #selector(confirmSelection), for: .touchUpInside)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        
        datePickerVC.view.addSubview(titleLabel)
        datePickerVC.view.addSubview(datePicker)
        datePickerVC.view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            
            titleLabel.centerXAnchor.constraint(equalTo: datePickerVC.view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: datePickerVC.view.topAnchor, constant: 40),
            titleLabel.widthAnchor.constraint(equalTo: datePickerVC.view.widthAnchor, multiplier: 0.9),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            datePicker.centerXAnchor.constraint(equalTo: datePickerVC.view.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            datePicker.widthAnchor.constraint(equalTo: datePickerVC.view.widthAnchor, multiplier: 0.9),
            datePicker.heightAnchor.constraint(equalToConstant: 200),
            
            confirmButton.centerXAnchor.constraint(equalTo: datePickerVC.view.centerXAnchor),
            confirmButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            confirmButton.widthAnchor.constraint(equalTo: datePickerVC.view.widthAnchor, multiplier: 0.9),
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        if let sheet = datePickerVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            
        }
        
        present(datePickerVC, animated: true)
    }
    

    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        let hour = seconds / 3600
        let min = (seconds % 3600) / 60
        let sec = (seconds % 3600) % 60
        return (hour, min, sec)
    }
    
    func makeTimeString(hour: Int, min: Int, sec: Int) -> String {
        return String(format: "%02d:%02d:%02d", hour, min, sec)
    }
    
    func updateLabel() {
        let time = secondsToHoursMinutesSeconds(remainingSeconds)
        timeTextField.text = makeTimeString(hour: time.0, min: time.1, sec: time.2)
    }
}
