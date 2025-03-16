//
//  SettingScheduleCell.swift
//  30MinRead
//
//  Created by 권정근 on 3/15/25.
//

import UIKit

class SettingScheduleCell: UITableViewCell {
    
    // MARK: - Variables
    static let reuseIdentifier: String = "SettingScheduleCell"
    weak var delegate: ScheduleTextFieldDelegate?
    
    // MARK: - UI Components
    private let titleLabel: UILabel = UILabel()
    private let textField: UITextField = UITextField()
    private let searchButton: UIButton = UIButton()
    private let stackView: UIStackView = UIStackView()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Functions
    func configure(title: String ,placeholder: String) {
        titleLabel.text = title
        textField.placeholder = placeholder
    }
    
    
    
    // MARK: - Layout
    private func setupUI() {
        titleLabel.text = "책"
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 1
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        textField.placeholder = "책 이름을 입력하세요"
        textField.textColor = .label
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .done
        
        searchButton.tintColor = .label
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.layer.cornerRadius = 5
        searchButton.layer.masksToBounds = true
        searchButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        searchButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(textField)
        //stackView.addArrangedSubview(searchButton)
        
        NSLayoutConstraint.activate([
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            titleLabel.widthAnchor.constraint(equalToConstant: 80),
            
            //searchButton.widthAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}

extension SettingScheduleCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.didTappedTextField()
    }
}


protocol ScheduleTextFieldDelegate: AnyObject {
    func didTappedTextField()
}
