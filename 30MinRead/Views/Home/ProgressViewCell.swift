//
//  ProgressViewCell.swift
//  30MinRead
//
//  Created by 권정근 on 3/16/25.
//

import UIKit

class ProgressViewCell: UITableViewCell {
    
    
    // MARK: - Variables
    static let reuseIdentifier: String = "ProgressViewCell"
    
    
    // MARK: - UI Components
    private lazy var titleLabel = customLabel(fontSize: 24, fontWeight: .black)
    private lazy var seperator: UIView = UIView()
    private lazy var pageLabel = customLabel(fontSize: 20, fontWeight: .medium)
    private lazy var dateLabel = customLabel(fontSize: 20, fontWeight: .medium)
    private lazy var timeLabel = customLabel(fontSize: 20, fontWeight: .black)
    private var innerStackView: UIStackView = UIStackView()
    private var moveButton: UIButton = UIButton(type: .system)
    private var totalStackView: UIStackView = UIStackView()
    
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        contentView.backgroundColor = .systemGray3
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    
    // MARK: - Functions
    private func customLabel(fontSize: Int, fontWeight: UIFont.Weight) -> UILabel  {
        let label = UILabel()
        label.font = .systemFont(ofSize: CGFloat(fontSize), weight: fontWeight)
        label.numberOfLines = 0
        label.textColor = .label
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }
    
    
    func configure(title: String, page: String, date: String, time: String) {
        titleLabel.text = "책 이름: " + title
        pageLabel.text = "페이지 수: " + page
        dateLabel.text = "독서 기간: " + date
        timeLabel.text = "독서 시간: " + time
    }
    
    
    private func setupUI() {
        
        seperator.backgroundColor = .black
        seperator.translatesAutoresizingMaskIntoConstraints = false
        
        innerStackView.axis = .vertical
        innerStackView.spacing = 8
        innerStackView.distribution = .fill
        innerStackView.alignment = .leading
        
        innerStackView.addArrangedSubview(titleLabel)
        innerStackView.addArrangedSubview(seperator)
        innerStackView.addArrangedSubview(pageLabel)
        innerStackView.addArrangedSubview(dateLabel)
        innerStackView.addArrangedSubview(timeLabel)
        
        moveButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        moveButton.tintColor = .black
        
        totalStackView.axis = .horizontal
        totalStackView.spacing = 10
        totalStackView.alignment = .fill
        totalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        totalStackView.addArrangedSubview(innerStackView)
        totalStackView.addArrangedSubview(moveButton)
        
        contentView.addSubview(totalStackView)
        
        NSLayoutConstraint.activate([
            
            seperator.widthAnchor.constraint(equalTo: innerStackView.widthAnchor),
            seperator.heightAnchor.constraint(equalToConstant: 2),
            
            totalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            totalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            totalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            totalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
            
        ])
        
    }
}
