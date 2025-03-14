//
//  SettingScheduleViewController.swift
//  30MinRead
//
//  Created by 권정근 on 3/15/25.
//

import UIKit

class SettingScheduleViewController: UIViewController {
    
    
    // MARK: - UI Components
    private var saveButton: UIButton = UIButton(type: .system)
    private var colorCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
    
        didTappedSaveButton()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 30, height: 30)
        colorCollectionView.collectionViewLayout = layout
    }
    
    
    // MARK: - Function
    private func didTappedSaveButton() {
        saveButton.addTarget(self, action: #selector(saveSchedule), for: .touchUpInside)
    }
    
    
    // MARK: - Actions
    @objc private func saveSchedule() {
        dismiss(animated: true)
    }
    
    
    // MARK: - Layout
    private func setupUI() {
        
        colorCollectionView.backgroundColor = .red
        colorCollectionView.showsHorizontalScrollIndicator = false
        colorCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(colorCollectionView)
        
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
            colorCollectionView.heightAnchor.constraint(equalToConstant: 30),
            
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }
}



