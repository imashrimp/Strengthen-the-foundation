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

class MemoListViewController: UIViewController {
    
    let realm = try! Realm()
    var walkThroughView: AlertView = AlertView(frame: .zero)
    var searchController: UISearchController = UISearchController(searchResultsController: nil)
    var popUpTimer: Timer?
    let creatMemoButton: UIButton = UIButton()
    let memoListTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return tableview
    }()
    let searchedMemoListTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableview.isHidden = true
       return tableview
    }()
    
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController // 이게 맞는지 모르겠음 => 내 생각이 맞으면 setNaviagtionBar()에서 'self.navigationItem.searchController = searchController'로 설정했기 때문에 문제가 없거나 \ 문제가 있으면 우변을 변수 'searchController'로 해야함
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty ?? false
        return isActive && isSearchBarHasText // 둘 다 true여야 true 반환, 둘 중 하나라도 false이면 false 반환
        // 서치컨트롤러도 활성화 상태이고, 서치바의 textfield에 텍스트가 입려된 상태여야 true를 반환함
    }
    var filterdMemo: Results<MemoObject>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configure()
        makeConstraint()
        showWalkThrough()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memoListTableView.reloadData()
        setNavigationBar()
        countMemo()
        setSearchView()
    }
    
    private func addSubViews() {
        self.view.addSubview(memoListTableView)
        self.view.addSubview(creatMemoButton)
        self.view.addSubview(searchedMemoListTableView)
    }
    
    private func configure() {
        memoListTableView.delegate = self
        memoListTableView.dataSource = self
        
        searchedMemoListTableView.delegate = self
        searchedMemoListTableView.dataSource = self
        
        searchController.searchBar.delegate = self
        
        creatMemoButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        creatMemoButton.addTarget(self, action: #selector(pushToWriteMemo), for: .touchUpInside)
        creatMemoButton.tintColor = .systemOrange
    }
    
    private func makeConstraint() {
        memoListTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        creatMemoButton.snp.makeConstraints { make in
            make.top.equalTo(memoListTableView.snp.bottom).offset(10)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.height.equalTo(70)
        }
        
        searchedMemoListTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setNavigationBar() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true // true면 스크롤 할 때 숨기고, false이면 스크롤 해도 서치바 계속 표시
    }
    
    private func setSearchView() {
        searchController.searchBar.placeholder = "검색"
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.searchBar.tintColor = .systemOrange
        searchController.automaticallyShowsCancelButton = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
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
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let totalMemoNumber = numberFormatter.string(for: memoObject.count) ?? "0"
        self.navigationItem.title = "\(totalMemoNumber)개의 메모"
    }
}

//MARK: - 서치바 구현
extension MemoListViewController: UISearchResultsUpdating { // ViewController에서 하는건지 UISearchController에서 하는건지 모르겠음
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else {return}
        filterdMemo = realm.objects(MemoObject.self).filter("entireMemo CONTAINS[c] %@", text)
        //        filteredFixedMemo = realm.objects(FixedMemoObject.self).filter("entireMemo CONTAINS[c] %@", text)
        // => 여기까지는 서치바를 통해서 realm에 저장된 '고정 메모'와 '일반 메모'를 불러올 수 있음
        // 이제 해야 될거는 이렇게 가져온 데이터를 사용해 셀의 갯수를 표현하고, 셀을 표현하는것 => 추가적으로는 섹션표현해서 하는 방법?
        self.memoListTableView.reloadData()
    }
}

extension MemoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SectionHeaderView()
        
        if section == 0 {
            header.headerLabel.text = "고정된 메모"
        } else {
            header.headerLabel.text = "메모"
        }
        header.headerLabel.textColor = .black
        return header
    }
    
    //MARK: - 스와이프 메서드

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let memoObject = realm.objects(MemoObject.self)
        let normalMemoObject = memoObject.where {
            $0.isFixed == "none"
        }
        let fixedMemoObject = memoObject.where {
            $0.isFixed == "fixed"
        }
        
        // 고정된 메모를 고정 해제 시킬 때
        if indexPath.section == 0 {
            let dismissMemo = UIContextualAction(style: .normal, title: "") { (_, _, success: @escaping (Bool) -> Void) in
                // 1. 고정 해제 할 메모 가져오기
                let memoToDismiss = fixedMemoObject[indexPath.row]
                // 2. 해당 메모의 'isFixed' 프로퍼티의 값을 'none'로 바꿔서 고정해제하기
                try! self.realm.write{
                    memoToDismiss.isFixed = "none"
                }
                tableView.reloadData()
                self.countMemo()
                success(true)
            }
            dismissMemo.backgroundColor = .systemOrange
            dismissMemo.image = UIImage(systemName: "pin.slash.fill")
            return UISwipeActionsConfiguration(actions: [dismissMemo])
        } else {  // 일반 메모를 고정 시킬 때
            let fixMemo = UIContextualAction(style: .normal, title: "") { (_, _, success: @escaping (Bool) -> Void) in
                // 1. MemoObject에 저장된 데이터 불러오기
                let memoToFix = normalMemoObject[indexPath.row]
                // 2. MemoObject의 'isFixed'프로퍼티의 값을 fixed로 업데이트
                try! self.realm.write{
                    memoToFix.isFixed = "fixed"
                }
                tableView.reloadData()
                self.countMemo()
                success(true)
            }
            fixMemo.backgroundColor = .systemOrange
            fixMemo.image = UIImage(systemName: "pin.fill")
            return UISwipeActionsConfiguration(actions: [fixMemo])
        }
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let memoObject = realm.objects(MemoObject.self)
        // 일반 메모에서만 셀 삭제 할 수 있도록
        if indexPath.section == 1 {
            let delete = UIContextualAction(style: .normal, title: "") { (_, _, success: @escaping (Bool) -> Void) in
                let memoToDelete = memoObject[indexPath.row]
                try! self.realm.write{
                    self.realm.delete(memoToDelete)
                }
                tableView.reloadData()
                self.countMemo()
                success(true)
            }
            delete.backgroundColor = .systemRed
            delete.image = UIImage(systemName: "trash.fill")
            return UISwipeActionsConfiguration(actions: [delete])
        } else {
            return nil
        }
    }
    
    //MARK: - 셀이 탭 되었을 때 해당 셀의 메모가 갖고 있는 데이터를 WriteMemoViewController에서 보여야함
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = WriteMemoViewController()
        let memoObject = realm.objects(MemoObject.self)
        let normalMemoObject = memoObject.where {
            $0.isFixed == "none"
        }
        let fixedMemoObject = memoObject.where {
            $0.isFixed == "fixed"
        }
        detailVC.distributor = "edit"
        
        // 고정된 메모의 경우
        if indexPath.section == 0 {
            detailVC.memoSequenceNumber = indexPath.row
            detailVC.memoSectionNumber = indexPath.section
            detailVC.textview.text = fixedMemoObject[indexPath.row].entireMemo
        } else {
            detailVC.memoSequenceNumber = indexPath.row
            detailVC.memoSectionNumber = indexPath.section
            detailVC.textview.text = normalMemoObject[indexPath.row].entireMemo
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MemoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let memoObject = realm.objects(MemoObject.self)
        let fixedMemoObject = memoObject.where {
            $0.isFixed == "fixed"
        }
    
        if section == 0 {
            return fixedMemoObject.count
        } else {
            return memoObject.count - fixedMemoObject.count
        }
    }
    
    // 이제 여기서 섹션별 셀의 UI프로퍼티 설정 하면 됨
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        let memoObject = realm.objects(MemoObject.self)
        let fixedMemoObject = memoObject.where {
            $0.isFixed == "fixed"
        }
        let normalMemoObject = memoObject.where {
            $0.isFixed == "none"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd a hh:mm"
        
        if indexPath.section == 0 {
            // 여기서 memoObject의 'isFixed'프로퍼티의 값이 "fixed"인 데이터만 가져와라가 되면 될거 같은데....
            cell.memoTitleLabel.text = fixedMemoObject[indexPath.row].memoTitle
            let memoDate = dateFormatter.string(from: fixedMemoObject[indexPath.row].memoDate)
            cell.memoWriteTimeLabel.text = memoDate
            cell.memodetailLabel.text = fixedMemoObject[indexPath.row].memoDetail
        } else {
            cell.memoTitleLabel.text = normalMemoObject[indexPath.row].memoTitle
            let memoDate = dateFormatter.string(from: normalMemoObject[indexPath.row].memoDate)
            cell.memoWriteTimeLabel.text = memoDate
            cell.memodetailLabel.text = normalMemoObject[indexPath.row].memoDetail
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

//MARK: - 서치바
extension MemoListViewController: UISearchBarDelegate {
    // 서치바에 값을 입력할 때마다 호출됨
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print(searchBar.text)
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("TextDidBeginEditing \(searchBar.text)")
    }
}

//MARK: - 앱 첫 실행 시 팝업창 관련 메서드
extension MemoListViewController {
    
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
        popUpTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(hidePopUp), userInfo: nil, repeats: false)
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
