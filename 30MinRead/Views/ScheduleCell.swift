//
//  ScheduleCell.swift
//  30MinRead
//
//  Created by 권정근 on 3/14/25.
//

import UIKit

class ScheduleCell: UICollectionViewCell {
    
    // MARK: - Variable
    static let reuseIdentifier: String = "ScheduleCell"

    // MARK: - UIComponent
    private let imageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let dateLabel: UILabel = UILabel()
    private let timeLabel: UILabel = UILabel()
    private let checkLabel: UILabel = UILabel()
    private let innerStackView: UIStackView = UIStackView()
    private let totalStackView: UIStackView = UIStackView()
    private let startButton: UIButton = UIButton(type: .system)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemGray
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFit // ✅ 이미지가 비율을 유지하도록 변경
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        dateLabel.textColor = .black
        dateLabel.textAlignment = .left
        dateLabel.font = .systemFont(ofSize: 18, weight: .regular)
        
        timeLabel.textColor = .black
        timeLabel.textAlignment = .left
        timeLabel.font = .systemFont(ofSize: 18, weight: .regular)
        
        checkLabel.textAlignment = .left
        checkLabel.numberOfLines = 0
        checkLabel.font = .systemFont(ofSize: 12, weight: .bold)
        
        startButton.setTitle("독서하기", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        startButton.backgroundColor = .black
        startButton.layer.cornerRadius = 10
        startButton.layer.masksToBounds = true
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        innerStackView.axis = .vertical
        innerStackView.spacing = 10
        innerStackView.distribution = .fill
        //innerStackView.alignment = .leading
        
        innerStackView.addArrangedSubview(titleLabel)
        innerStackView.addArrangedSubview(dateLabel)
        innerStackView.addArrangedSubview(timeLabel)
        innerStackView.addArrangedSubview(checkLabel)
        innerStackView.addArrangedSubview(startButton)
        
        totalStackView.axis = .horizontal
        totalStackView.spacing = 10
        totalStackView.distribution = .fill // ✅ 두 개의 뷰가 균등한 크기를 가지도록 설정
        totalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        totalStackView.addArrangedSubview(imageView)
        totalStackView.addArrangedSubview(innerStackView)
        
        contentView.addSubview(totalStackView)
        
        NSLayoutConstraint.activate([
            
            totalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            totalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            totalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            totalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 80),
            startButton.heightAnchor.constraint(equalToConstant: 40),
            
            imageView.widthAnchor.constraint(equalToConstant: 160),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: String, title: String, date: String, time: String, check: String) {
        imageView.image = UIImage(named: image)
        titleLabel.text = title
        dateLabel.text = date
        timeLabel.text = time
        checkLabel.text = check
    }
}

