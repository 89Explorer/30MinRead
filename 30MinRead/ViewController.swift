//
//  ViewController.swift
//  30MinRead
//
//  Created by 권정근 on 3/13/25.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: - UI Component
    private var timeLabel: UILabel = UILabel()
    private var startStopButton: UIButton = UIButton(type: .system)
    private var resetButton: UIButton = UIButton(type: .system)

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        timeLabel.text = "00:30:00"
        timeLabel.font = .systemFont(ofSize: 40, weight: .bold)
        timeLabel.textColor = .black
        timeLabel.textAlignment = .center
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        startStopButton.setTitle("START", for: .normal)
        startStopButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        startStopButton.tintColor = .black
        startStopButton.backgroundColor = .systemGreen
        startStopButton.layer.cornerRadius = 10
        startStopButton.layer.masksToBounds = true
        
        resetButton.setTitle("RESET", for: .normal)
        resetButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        resetButton.tintColor = .black
        resetButton.backgroundColor = .systemRed
        resetButton.layer.cornerRadius = 10
        resetButton.layer.masksToBounds = true
        
        let stackView = UIStackView()
        stackView.addArrangedSubview(startStopButton)
        stackView.addArrangedSubview(resetButton)
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(timeLabel)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            timeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            timeLabel.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }

}

