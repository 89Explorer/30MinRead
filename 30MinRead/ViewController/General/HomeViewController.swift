//
//  HomeViewController.swift
//  30MinRead
//
//  Created by 권정근 on 3/16/25.
//

import UIKit

class HomeViewController: UIViewController {
    
     
    // MARK: - Variables
    let sectionTitle: [String] = ["일정표", "진행 중인 계획"]
    

    // MARK: - UI Components
    private let tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    
    
    // MARK: - Life Cycle 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBrown
        setupNavigationLeftTitle()
        setupUI()
        
    }
    
    
    // MARK: - Function
    private func setupUI() {
       
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CalendarViewCell.self, forCellReuseIdentifier: CalendarViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
            
        ])
    }
}



// MARK: - Extension: 네비게이션바 왼쪽에 타이틀 설정
extension HomeViewController {
    
    private func setupNavigationLeftTitle() {
        let titleLabel: UILabel = UILabel()
        titleLabel.text = "Home"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textColor = .black
        
        let leftBarButton = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = leftBarButton
    }
}



// MARK: - Extension: tableView 델리게이트 설정
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = TableSection.allCases[indexPath.section]
        
        switch section {
        case .calendar:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CalendarViewCell.reuseIdentifier, for: indexPath) as? CalendarViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            
            return cell
            
        case .plan:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "TEST"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 24, weight: .black)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .label
        header.backgroundColor = .red
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30 // 섹션 간 간격
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacerView = UIView()
        spacerView.backgroundColor = .clear // 투명한 뷰 추가
        return spacerView
    }

}


enum TableSection: CaseIterable {
    case calendar
    case plan
}
