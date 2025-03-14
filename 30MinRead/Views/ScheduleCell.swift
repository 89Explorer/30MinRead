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
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemBrown
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
        checkLabel.text = "✅ ✅ ✅ ✅"
        checkLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        
        innerStackView.axis = .vertical
        innerStackView.spacing = 10
        innerStackView.distribution = .fillEqually
        innerStackView.alignment = .leading
        
        innerStackView.addArrangedSubview(titleLabel)
        innerStackView.addArrangedSubview(dateLabel)
        innerStackView.addArrangedSubview(timeLabel)
        innerStackView.addArrangedSubview(checkLabel)
        
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
            
            imageView.widthAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: String, title: String, date: String, time: String) {
        imageView.image = UIImage(named: image)
        titleLabel.text = title
        dateLabel.text = date
        timeLabel.text = time
    }
}

