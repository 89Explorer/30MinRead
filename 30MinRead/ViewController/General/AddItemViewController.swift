//
//  AddItemViewController.swift
//  30MinRead
//
//  Created by 권정근 on 3/17/25.
//

import UIKit

class AddItemViewController: UIViewController {
    
    
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
    
    
    // MARK: - Function
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
        titleTextField.returnKeyType = .next
        
        pageTextField.placeholder = "전체 페이지수를 입력하세요"
        pageTextField.keyboardType = .numberPad
        pageTextField.returnKeyType = .next
        
        dateTextField.placeholder = "독서 기간을 선택하세요"
        dateTextField.delegate = self
        
        timeTextField.placeholder = "독서 시간을 입력하세요"
        
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
        
        NSLayoutConstraint.activate([
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
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
            present(datePickerVC, animated: true)
//            datePickerVC.modalPresentationStyle = .pageSheet
//            present(datePickerVC, animated: true)
            return false
        }
        
        
        
        return true
    }
}
