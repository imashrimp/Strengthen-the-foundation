//
//  ViewController.swift
//  MemoApp
//
//  Created by 권현석 on 2023/04/21.
//

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
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

// 아래의 이것도 수정했던거 같은데 기억이 안남
        let memos = realm.objects(MemoObject.self)
        let memosNumber = memos.count
        
        self.navigationItem.title = "\(memosNumber)개의 메모"
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
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SectionHeaderView()
        return header
    }
    
    //MARK: - 스와이프 메서드
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        // 여기서는 leading swipe로 해당 셀 고정하기
//    }
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        // 여기서는 trailing swipe로 해당 셀 제거하기
//    }
    
    //MARK: - 셀이 탭 되었을 때 해당 셀의 메모가 갖고 있는 데이터를 WriteMemoViewController에서 보여야함
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = WriteMemoViewController()
        let memos = realm.objects(MemoObject.self)

        detailVC.textview.text = memos[indexPath.row].memoTitle + memos[indexPath.row].memoDetail
        // 여기서 데이터 전달해야함
//        detailVC.textview =
        // 위와 같은 형태로 하는데, memos[indexPath.row].memoTitle은 첫 줄에 배치되도록 하고, memos[indexPath.row].memoDetail은 두번째 줄 부터 표시되도록 하는데, 띄어쓰기를 구분자로 둬 띄어쓰기마다 줄이 바뀌어 textView에 표현될 수 있도록
        
        // 1. textview의 특정 줄 번호 찾는 법 알기
        // 2. memos[indexPath.row].memoDetail의 데이터를 띄어쓰기마다 데이터 따로 받는 법 알기 (아니면 저장할 때, 배열 형태로 저장해 콤마로 구분해 데이터 구분하기)
        // 3. 2번에서 받아온 데이터 사용해 textview줄을 구분해 표시하기
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 여기서는 realm을 통해 저장한 데이터의 숫자를 반환하기
        let memos = realm.objects(MemoObject.self)
        return memos.count
    }
    
    // section을 매개변수로 추가해서 section0에서의 셀 설정과 section1에서의 셀 설정을 다시 해야하지 않을까? 그리고 이걸 하면 tableView.reloadData()이거 해줘야 할 듯
    // 근데 매개변수에 section을 넣으면 dataSource를 만족하는 메서드가 아니라 문제가 생김
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        // realm에 저장된 데이터를 cell의 label에 할당하기
        let memos = realm.objects(MemoObject.self) // 이거는 컬렉션 타입
        cell.memoTitleLabel.text = memos[indexPath.row].memoTitle
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd a hh:mm"
        let memoDate = dateFormatter.string(from: memos[indexPath.row].memoDate)
        cell.memoWriteTimeLabel.text = memoDate
        cell.memodetailLabel.text = memos[indexPath.row].memoDetail
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // 이거는 고민 좀 해보자
        return 1
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
