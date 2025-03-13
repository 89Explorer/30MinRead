//
//  ViewController.swift
//  30MinRead
//
//  Created by 권정근 on 3/13/25.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: - Variable
    private var timerCounting: Bool = false
    private var remainingSeconds: Int = 0
    private var scheduledTimer: Timer?
    
    
    private let userDefaults = UserDefaults.standard
    private let remaining_Time_Key: String = "remaining_Time_Key"
    private let counting_Key: String = "counting_Key"
    
    
    // 📌 MARK: - UI Component
    private var timerLabel: UILabel = UILabel()
    private var startStopButton: UIButton = UIButton(type: .system)
    private var resetButton: UIButton = UIButton(type: .system)
    private var innerStackView: UIStackView = UIStackView()
    
    
    // 📌 MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        
        let timePickerGesture = UITapGestureRecognizer(target: self, action: #selector(showTimerPicker))
        timerLabel.addGestureRecognizer(timePickerGesture)
        
        setupUI()
        
        // ✅ 저장된 상태 불러오기
        timerCounting = userDefaults.bool(forKey: counting_Key)
        remainingSeconds = userDefaults.integer(forKey: remaining_Time_Key)
        
        
        if timerCounting {
            print("타이머 시작")
        } else {
            print("타이머 정지")
        }
        
        // 버튼 액션 추가
        startStopButton.addTarget(self, action: #selector(startStopAction), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetAction), for: .touchUpInside)
        
    }
    
    
    // 📌 MARK: - Function
    
    func startTimer() {
        scheduledTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
        setTimeCounting(true)
        startStopButton.setTitle("STOP", for: .normal)
        startStopButton.setTitleColor(.systemRed, for: .normal)
    }
    
    func stopTimer() {
        scheduledTimer?.invalidate()
        setTimeCounting(false)
        startStopButton.setTitle("START", for: .normal)
        startStopButton.setTitleColor(.white, for: .normal)
    }
    
    func setTimeCounting(_ value: Bool) {
        timerCounting = value
        userDefaults.set(timerCounting, forKey: counting_Key)
    }
    
    
    /// 초 단위 시간을 시간:분:초로 변환하는 메서드
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        let hour = seconds / 3600
        let min = (seconds % 3600) / 60
        let sec = (seconds % 3600) % 60
        return (hour, min, sec)
    }
    
    
    /// 시간을 00:00:00 형식의 문자열로 변환하는 메서드
    func makeTimeString(hour: Int, min: Int, sec: Int) -> String {
        return String(format: "%02d:%02d:%02d", hour, min, sec)
    }
    
    
    /// 화면에 남은 시간을 표시하는 메서드
    func updateLabel() {
        let time = secondsToHoursMinutesSeconds(remainingSeconds)
        timerLabel.text = makeTimeString(hour: time.0, min: time.1, sec: time.2)
    }
    
    
    /// UI 설정 메서드
    private func setupUI() {
        timerLabel.text = "00:00:00"
        timerLabel.font = .systemFont(ofSize: 70, weight: .bold)
        timerLabel.textColor = .white
        timerLabel.textAlignment = .center
        timerLabel.isUserInteractionEnabled = true
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        startStopButton.setTitle("START", for: .normal)
        startStopButton.setTitleColor(.white, for: .normal)
        startStopButton.backgroundColor = .systemGreen
        startStopButton.titleLabel?.font = .systemFont(ofSize: 40, weight: .bold)
        startStopButton.layer.cornerRadius = 20
        startStopButton.layer.masksToBounds = true
        
        
        resetButton.setTitle("RESET", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.backgroundColor = .systemRed
        resetButton.titleLabel?.font = .systemFont(ofSize: 40, weight: .bold)
        resetButton.layer.cornerRadius = 20
        resetButton.layer.masksToBounds = true
        
        innerStackView.addArrangedSubview(startStopButton)
        innerStackView.addArrangedSubview(resetButton)
        innerStackView.axis = .horizontal
        innerStackView.distribution = .fillEqually
        innerStackView.spacing = 30
        innerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(timerLabel)
        view.addSubview(innerStackView)
        
        NSLayoutConstraint.activate([
            
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            timerLabel.heightAnchor.constraint(equalToConstant: 60),
            
            innerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            innerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            innerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            innerStackView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 30),
            innerStackView.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }
    
    
    
    // MARK: - Action
    /// 타이머 선택하는 메서드
    @objc private func showTimerPicker() {
        print("showTimerPicker called")
        
        let alert = UIAlertController(title: "독서에 집중하실 시간을 선택해주세요", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .countDownTimer
        timePicker.locale = Locale(identifier: "ko_KR")
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.frame = CGRect(x: 10, y: 30, width: alert.view.bounds.width - 20, height: 200)
        
        alert.view.addSubview(timePicker)
        
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            let selectedTime = Int(timePicker.countDownDuration)
            self.remainingSeconds = selectedTime
            self.updateLabel()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
    }
    
    @objc private func refreshValue() {
        if remainingSeconds > 0 {
            remainingSeconds -= 1
            userDefaults.set(remainingSeconds, forKey: remaining_Time_Key)
            updateLabel()
        } else {
            stopTimer()
        }
    }
    
    @objc func startStopAction() {
        if timerCounting {
            stopTimer()
        } else {
            if remainingSeconds > 0 {
                userDefaults.set(remainingSeconds, forKey: remaining_Time_Key)
            }
            startTimer()
        }
    }
    
    @objc func resetAction() {
        stopTimer()
        remainingSeconds = 0
        userDefaults.set(remainingSeconds, forKey: remaining_Time_Key)
        updateLabel()
    }
}
