//
//  ViewController.swift
//  MemoApp
//
//  Created by 권현석 on 2023/04/21.
//

// 할거
// 서치바 설정하기
// tableView cell swipe기능 설정하기
// walkThroughView를 큰 뷰 안에 넣어서 그 큰 뷰의 백그라운드를 살짝 투명하게 해서 뒤에 보이는 메모앱 화면이 살짝 비춰지게 하기

// 1. 메모 작성 후 완료 버튼 누르면 메모가 저장되어 메모 리스트에 추가되게 하기

import Foundation
import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let tableView: UITableView = UITableView()
    let customView: CustomView = CustomView()
    var walkThroughView: AlertView = AlertView(frame: .zero)
    var timer: Timer?
    let creatMemoButton: UIButton = UIButton()
    var memoDate: Date = Date()
    
    //    var numberOfCell: Int?
    //    let numberFormatter = NumberFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configure()
        makeConstraint()
        showWalkThrough()
    }
    
    private func addSubViews() {
        // 네비게이션 타이틀에 뭐가 더 필요할거 같은데...?
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customView.memoCountLabel)
        self.view.addSubview(customView.verticalStackView)
        self.view.addSubview(creatMemoButton)
    }
    
    private func configure() {
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        
        creatMemoButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        creatMemoButton.addTarget(self, action: #selector(createNewMemo), for: .touchUpInside)
        // 버튼 사이즈 조절하는거 잘 모르겠음
        creatMemoButton.tintColor = .systemOrange
        creatMemoButton.backgroundColor = .black
    }
    
    private func makeConstraint() {
        
        customView.verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        creatMemoButton.snp.makeConstraints { make in
            make.top.equalTo(customView.verticalStackView.snp.bottom).offset(10)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.height.equalTo(70)
        }
    }
}

// 한 섹션은 헤더, 로우, 푸터로 구성되어 있음 그러므로 tableviewDelegate에서 헤더를 설정하며 section 스타일 중 'insetgrouped'를 사용해 모서리가 둥글고 inset이 설정된 섹션 만들기
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SectionHeaderView()
        
        if section == 0 {
            header.headerLabel.text = "고정된 메모"
        } else {
            header.headerLabel.text = "메모"
        }
        return header
    }
    
    // 스와이프는 끝까지 밀거나 적당히 밀어서 탭하면 작동함
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let memoFixed = UIContextualAction(style: .normal, title: "") { (_, _, success: @escaping (Bool) -> Void) in
            print("메모가 고정되어 고정섹션에 표시됨")
            // 메모를 고정 할 로직 작성해야함
            success(true)
        }
        memoFixed.backgroundColor = .systemOrange
        // 고정된 메모에는 "pin.slash.fill"로 이미지 바뀌게 하기
        memoFixed.image = UIImage(systemName: "pin.fill")
        return UISwipeActionsConfiguration(actions: [memoFixed])
    }
    
    // 스와이프하면 제거 아이콘 까지는 뜸
    // 할거
    // 현재 제거 작동시키면 앱이 터짐
    // 제거 버튼 누르면 알림창을 띄워 제거 여부를 다시 한 번 묻고, 확인을 누르면 제거되어야함
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "") { (_, _, success: @escaping (Bool) -> Void) in
            // 여기서 제거하는게 문제인 듯
            tableView.deleteRows(at: [indexPath], with: .fade)
            success(true)
        }
        
        delete.backgroundColor = .systemRed
        delete.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [delete])
    }
}


extension ViewController: UITableViewDataSource {
    // 셀을 뱉어내는거는 셀 추가에 의해 진행됨
    // 섹션의 indexRow에 맞게 cell값 반환해야함
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // 여기서 뱉어내는 셀의 갯수를 받아 customView에서 NumberFormatter를 사용해야함
        return 5
    }
    
    // 여기서는 뱉어낼 셀을 설정해야함 => 그 이전에 tableViewCell도 만들어서 등록해야함
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        // 이거 indexPath값 받아와서 수정해야 할 듯 그리고 이거를 numberFormatter를 사용해 보기 좋은 형태로 바꿀 수 있음
        cell.memoWriteTimeLabel.text = "\(memoDate)"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}


//MARK: - 앱 첫 실행 시 팝업창 관련 메서드
extension ViewController {
    
    func showWalkThrough() {
        let i = UserDefaults.standard.string(forKey: "walkThrough")
        if i == "Done" {
            walkThroughView.isHidden = true
        } else {
            loadPopUp()
            dismissPopUp()
        }
    }
    
    func dismissPopUp() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(hidePopUp), userInfo: nil, repeats: false)
    }
    
    @objc func hidePopUp() {
        walkThroughView.isHidden = true
        UserDefaults.standard.set("Done", forKey: "walkThrough")
    }
    
    func loadPopUp() {
        walkThroughView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(walkThroughView)
        walkThroughView.backgroundColor = .black
        walkThroughView.layer.cornerRadius = 15
        walkThroughView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.size.equalTo(200)
        }
    }
}

extension ViewController {
    
    @objc func createNewMemo() {
        let vc = WriteMemoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
