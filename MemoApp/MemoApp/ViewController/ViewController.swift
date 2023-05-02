//
//  ViewController.swift
//  MemoApp
//
//  Created by 권현석 on 2023/04/21.
//

// 할 일
// textview에 아무것도 입력 안 하고 완료 눌렀을 때 메모가 저장이 안 되도록
// 메모 갯수 표시 기능 항상 작동되도록 'setNavigationBar()'
// 서치바 기능

import Foundation
import UIKit
import SnapKit
import RealmSwift

class ViewController: UIViewController {
    
    let realm = try! Realm()
    var walkThroughView: AlertView = AlertView(frame: .zero)
    var searchVC: UISearchController = UISearchController(searchResultsController: nil)
    var timer: Timer?
    let creatMemoButton: UIButton = UIButton()
    let tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configure()
        makeConstraint()
        showWalkThrough()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        setNavigationBar()
        countMemo()
        setSearchVC()
    }
    
    private func addSubViews() {
        self.view.addSubview(tableView)
        self.view.addSubview(creatMemoButton)
    }
    
    private func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        
        creatMemoButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        creatMemoButton.addTarget(self, action: #selector(pushToWriteMemo), for: .touchUpInside)
        creatMemoButton.tintColor = .systemOrange
    }
    
    private func makeConstraint() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        creatMemoButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(10)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.height.equalTo(70)
        }
    }
    
    private func setNavigationBar() {
        self.view.backgroundColor = .white
        
//        let memos = realm.objects(MemoObject.self)
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .decimal
//        let memosNumber = numberFormatter.string(for: memos.count) ?? "0" // 이게 셀 고정 해제 마다 반영이 안됨
//        
//        self.navigationItem.title = "\(memosNumber)개의 메모"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchVC
    }
    
    private func setSearchVC() {
        searchVC.searchBar.placeholder = "검색"
        searchVC.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchVC.searchBar.tintColor = .systemOrange
        searchVC.automaticallyShowsCancelButton = true
        searchVC.obscuresBackgroundDuringPresentation = false
    }
    
    @objc func pushToWriteMemo() {
        let vc = WriteMemoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 이 메서드는 일반 메모와, 고정된 메모의 갯수가 바뀌었을 때마다 실행해줘야함 => 이거 롤에서 비슷한거 했던거 같은데
    // 1. 리딩스와이프, 트레일링 스와이프
    // 2. 메모 추가 => 이거는 willAppear()에서 됨
    func countMemo() {
        // 여기서는 일반 메모의 갯수랑 고정메모의 갯수의 합을 구하면 됨
        let memoObject = realm.objects(MemoObject.self)
        let fixedMemoObject = realm.objects(FixedMemoObject.self)
        let totalMemoCount = memoObject.count + fixedMemoObject.count
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let totalMemoNumber = numberFormatter.string(for: totalMemoCount) ?? "0"
        self.navigationItem.title = "\(totalMemoNumber)개의 메모"
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SectionHeaderView()
        let fixedMemoObject = self.realm.objects(FixedMemoObject.self)
        // 고정된 메모가 없는 경우
        if fixedMemoObject.count == 0 {
            header.headerLabel.text = "메모"
        } else { // 고정된 메모가 있는 경우
            
            if section == 0 { // 고정된 메모의 헤더 라벨 설정
                header.headerLabel.text = "고정된 메모"
            } else { // 일반 메모의 헤더 라벨 설정
                header.headerLabel.text = "메모"
            }
        }
        header.headerLabel.textColor = .black
        return header
    }
    
    //MARK: - 스와이프 메서드
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let memoObject = self.realm.objects(MemoObject.self)
        let fixedMemoObject = self.realm.objects(FixedMemoObject.self)
        
        if fixedMemoObject.count == 0 { // 고정된 메모가 없을 때
            let memoFixed = UIContextualAction(style: .normal, title: "") { (_, _, success: @escaping (Bool) -> Void) in
                // 1. MemoObject에 저장된 데이터 불러오기
                let memoToDelete = memoObject[indexPath.row]
                // 2. 이를 FixedMemoObject에 저장하기
                let fixedMemo = FixedMemoObject(memoTitle: memoToDelete.memoTitle, memoDetail: memoToDelete.memoDetail, entireMemo: memoToDelete.entireMemo)
                try! self.realm.write{
                    self.realm.add(fixedMemo)
                }
                // 3. MemoObject에 저장된 데이터 삭제하기
                try! self.realm.write{
                    self.realm.delete(memoToDelete)
                }
                
                // 이걸 하면 셀 표현하는 메서드에서 고정 메모 나타내는 코드랑 일반 메모 나타내는 코드 구분해야함
                tableView.reloadData()
                self.countMemo()
                success(true)
            }
            memoFixed.backgroundColor = .systemOrange
            memoFixed.image = UIImage(systemName: "pin.fill")
            return UISwipeActionsConfiguration(actions: [memoFixed])
        } else { // 고정된 메모가 있는 경우
            if indexPath.section == 0 { // 고정된 메모 섹션의 리딩 스와이프 설정
                let dismissMemo = UIContextualAction(style: .normal, title: "") { (_, _, success: @escaping (Bool) -> Void) in
                    // 1. FixedMemoObject에 저장된 데이터 불러오기
                    let fixedMemoToDismiss = fixedMemoObject[indexPath.row]
                    // 2. 이를 MemoObject에 저장하기
                    let memoToNormal = MemoObject(memoTitle: fixedMemoToDismiss.memoTitle, memoDetail: fixedMemoToDismiss.memoDetail, entireMemo: fixedMemoToDismiss.entireMemo)
                    try! self.realm.write{
                        self.realm.add(memoToNormal)
                    }
                    // 3. FixedMemoObject에 저장된 데이터 삭제하기
                    try! self.realm.write{
                        self.realm.delete(fixedMemoToDismiss)
                    }
                    tableView.reloadData()
                    self.countMemo()
                    success(true)
                }
                dismissMemo.backgroundColor = .systemOrange
                dismissMemo.image = UIImage(systemName: "pin.slash.fill")
                return UISwipeActionsConfiguration(actions: [dismissMemo])
            } else { // 일반 메모의 섹션 리딩 스와이프 설정
                let memoFixed = UIContextualAction(style: .normal, title: "") { (_, _, success: @escaping (Bool) -> Void) in
                    // 1. MemoObject에 저장된 데이터 불러오기
                    let memoToDelete = memoObject[indexPath.row]
                    // 2. 이를 FixedMemoObject에 저장하기
                    let fixedMemo = FixedMemoObject(memoTitle: memoToDelete.memoTitle, memoDetail: memoToDelete.memoDetail, entireMemo: memoToDelete.entireMemo)
                    try! self.realm.write{
                        self.realm.add(fixedMemo)
                    }
                    // 3. MemoObject에 저장된 데이터 삭제하기
                    try! self.realm.write{
                        self.realm.delete(memoToDelete)
                    }
                    
                    // 이걸 하면 셀 표현하는 메서드에서 고정 메모 나타내는 코드랑 일반 메모 나타내는 코드 구분해야함
                    tableView.reloadData()
                    self.countMemo()
                    success(true)
                }
                memoFixed.backgroundColor = .systemOrange
                memoFixed.image = UIImage(systemName: "pin.fill")
                return UISwipeActionsConfiguration(actions: [memoFixed])
            }
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 여기서는 trailing swipe로 해당 셀 제거하기
        let fixedMemoObject = realm.objects(FixedMemoObject.self)
        if fixedMemoObject.count == 0 {
            let delete = UIContextualAction(style: .normal, title: "") { (_, _, success: @escaping (Bool) -> Void) in
                let memoObject = self.realm.objects(MemoObject.self)
                // 지울 메모 지정
                let memoToDelete = memoObject[indexPath.row]
                // realm에서 데이터 삭제
                try! self.realm.write{
                    self.realm.delete(memoToDelete)
                }
                self.countMemo()
                tableView.reloadData()
                // 스와이프 액션 작동
                success(true)
                // 테이블 뷰 리로드해서 해당 셀 삭제하기
                
            }
            delete.backgroundColor = .systemRed
            delete.image = UIImage(systemName: "trash.fill")
            return UISwipeActionsConfiguration(actions: [delete])
        } else {
            if indexPath.section == 0 {
                return nil
            } else {
                let delete = UIContextualAction(style: .normal, title: "") { (_, _, success: @escaping (Bool) -> Void) in
                    let memoObject = self.realm.objects(MemoObject.self)
                    // 지울 메모 지정
                    let memoToDelete = memoObject[indexPath.row]
                    // realm에서 데이터 삭제
                    try! self.realm.write{
                        self.realm.delete(memoToDelete)
                    }
                    self.countMemo()
                    tableView.reloadData()
                    // 스와이프 액션 작동
                    success(true)
                    // 테이블 뷰 리로드해서 해당 셀 삭제하기
                }
                delete.backgroundColor = .systemRed
                delete.image = UIImage(systemName: "trash.fill")
                return UISwipeActionsConfiguration(actions: [delete])
            }
        }
        

    }
    
    //MARK: - 셀이 탭 되었을 때 해당 셀의 메모가 갖고 있는 데이터를 WriteMemoViewController에서 보여야함
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = WriteMemoViewController()
        let memos = realm.objects(MemoObject.self)
        let fixedMemoObject = realm.objects(FixedMemoObject.self)
        detailVC.distributor = "edit"
        
        if fixedMemoObject.count == 0 {
            // 메모를 수정을 위해 사용하는 프로퍼티
            // 그리고 realm에 있는 특정 순서의 데이터를 바꾸기 위해
            detailVC.memoSequenceNumber = indexPath.row
            detailVC.memoSectionIdentifier = "normal" // 이때는 0임 => 왜냐? 섹션이 하나뿐이거든
            detailVC.textview.text = memos[indexPath.row].entireMemo
        } else {
            if indexPath.section == 0 {
                detailVC.memoSequenceNumber = indexPath.row
                detailVC.memoSectionIdentifier = "fixed" // 이때는 0임 => 왜냐? 고정된 메모의 섹션 번호가 '0' 이거든
                detailVC.textview.text = fixedMemoObject[indexPath.row].entireMemo
            } else {
                detailVC.memoSequenceNumber = indexPath.row
                detailVC.memoSectionIdentifier = "normal" // 이때는 1임 => 왜냐? 일반 메모의 섹션 번호는 '1' 이거든
                detailVC.textview.text = memos[indexPath.row].entireMemo
            }
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    // 이것도 바꿔야하네
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let memoObject = realm.objects(MemoObject.self)
        let fixedMemoObject = realm.objects(FixedMemoObject.self)
        
        // 고정된 메모가 없어서 일반 메모만 나타낼 때
        if fixedMemoObject.count == 0 {
            return memoObject.count
        } else { // 고정된 메모가 있을 때
            if section == 0 {
                // 고정된 메모 섹션에 나타낼 셀의 수
                return fixedMemoObject.count
            } else {
                // 일반 메모 섹션에 나타낼 셀의 수
                return memoObject.count
            }
        }
    }
    
    // 이제 여기서 섹션별 셀의 UI프로퍼티 설정 하면 됨
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        let fixedMemoObject = realm.objects(FixedMemoObject.self)
        let memoObject = realm.objects(MemoObject.self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd a hh:mm"
        
        if fixedMemoObject.count == 0 {
            cell.memoTitleLabel.text = memoObject[indexPath.row].memoTitle
            let memoDate = dateFormatter.string(from: memoObject[indexPath.row].memoDate)
            cell.memoWriteTimeLabel.text = memoDate
            cell.memodetailLabel.text = memoObject[indexPath.row].memoDetail
        } else {
            if indexPath.section == 0 {
                cell.memoTitleLabel.text = fixedMemoObject[indexPath.row].memoTitle
                let memoDate = dateFormatter.string(from: fixedMemoObject[indexPath.row].memoDate)
                cell.memoWriteTimeLabel.text = memoDate
                cell.memodetailLabel.text = fixedMemoObject[indexPath.row].memoDetail
            } else {
                cell.memoTitleLabel.text = memoObject[indexPath.row].memoTitle
                let memoDate = dateFormatter.string(from: memoObject[indexPath.row].memoDate)
                cell.memoWriteTimeLabel.text = memoDate
                cell.memodetailLabel.text = memoObject[indexPath.row].memoDetail
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // 이거는 고민 좀 해보자
        let fixedMemoObject = self.realm.objects(FixedMemoObject.self)
        if fixedMemoObject.count == 0 {
            return 1
        } else {
            return 2
        }
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
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(hidePopUp), userInfo: nil, repeats: false)
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
