//
//  ViewController.swift
//  MemoApp
//
//  Created by 권현석 on 2023/04/21.
//

// 할거
// 서치바 설정하기
// 섹션 두 개로 나누고 섹션별 위에 헤더(?) 설정하기
// 섹션 사이 거리 띄우기
// tableView cell swipe기능 설정하기

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let tableView: UITableView = UITableView()
    let customView: CustomView = CustomView(frame: .zero)
    var walkthroughView: AlertView = AlertView(frame: .zero)
    var timer: Timer?
    let searchBar: UISearchBar = UISearchBar() // 서치바 설정하는거 더 찾아보기
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showWalkThrough()
        addSubViews()
        configure()
        makeConstraint()
    }
    
    private func addSubViews() {
        // 네비게이션 타이틀에 뭐가 더 필요할거 같은데...?
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customView.memoCountLabel)
        self.view.addSubview(tableView)
    }
    
    private func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.backgroundColor = .black
        
// 네비게이션 바 색깔 설정하는거는 테이블 뷰에 셀 불러온 다음 레이아웃 보면서 해보자
//        self.navigationController?.navigationBar.backgroundColor = .darkGray
        self.view.backgroundColor = .black
    }
    
    private func makeConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
}

// 한 섹션은 헤더, 로우, 푸터로 구성되어 있음 그러므로 tableviewDelegate에서 헤더를 설정하며 section 스타일 중 'insetgrouped'를 사용해 모서리가 둥글고 inset이 설정된 섹션 만들기
extension ViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

extension ViewController: UITableViewDataSource {
    // 셀을 뱉어내는거는 셀 추가에 의해 진행됨
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    // 여기서는 뱉어낼 셀을 설정해야함 => 그 이전에 tableViewCell도 만들어서 등록해야함
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        return cell
    }
}

extension ViewController {
    
    func showWalkThrough() {
        let i = UserDefaults.standard.string(forKey: "walkThrough")
        
        if i == "Done" {
            walkthroughView.isHidden = true
        } else {
            loadPopUp()
            dismissPopUp()
        }
    }
    
    func dismissPopUp() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(hidePopUp), userInfo: nil, repeats: false)
    }
    
    @objc func hidePopUp() {
        walkthroughView.isHidden = true
        UserDefaults.standard.set("Done", forKey: "walkThrough")
    }
    
    func loadPopUp() {
        walkthroughView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(walkthroughView)
        walkthroughView.backgroundColor = .darkGray
        walkthroughView.layer.cornerRadius = 15
        walkthroughView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.size.equalTo(200)
        }
    }
}
