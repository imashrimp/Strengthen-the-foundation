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
        tableview.register(MemoListTableViewCell.self, forCellReuseIdentifier: MemoListTableViewCell.identifier)
        return tableview
    }()
    
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        // 둘 다 true여야 true 반환, 둘 중 하나라도 false이면 false 반환
        return isActive && isSearchBarHasText
    }
    /// 서치바에 입련된 character를 entireMemo 프로퍼티의 값으로 가진 memoObject
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
    }
    
    private func configure() {
        memoListTableView.delegate = self
        memoListTableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        
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
    }
    
    private func setNavigationBar() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func setSearchView() {
        searchController.searchBar.tintColor = .systemOrange
        searchController.searchBar.placeholder = "검색"
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.automaticallyShowsCancelButton = true
        // 서치바를 탭 했을 때 아래의 테이블뷰가 흐릿해지면 true, 아니면 false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
    }
    
    @objc func pushToWriteMemo() {
        let vc = WriteMemoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

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
extension MemoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else {return}
        // TODO: filteredMemo를 realm의 where를 사용해서 해보자
        filterdMemo = realm.objects(MemoObject.self).filter("entireMemo CONTAINS[c] %@", text)
        self.memoListTableView.reloadData()
    }
}

extension MemoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SectionHeaderView()
        
        if self.isFiltering == true {
            header.isHidden = true
        } else {
            if section == 0 {
                header.headerLabel.text = "고정된 메모"
            } else {
                header.headerLabel.text = "메모"
            }
            header.headerLabel.textColor = .black
        }
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
        
        // 서치바로 검색한 메모를 선택한 경우
        if self.isFiltering == true {
            detailVC.searchedMemo = true
            detailVC.searchKeyWord = searchController.searchBar.text
            detailVC.memoSequenceNumber = indexPath.row
            detailVC.textview.text = filterdMemo?[indexPath.row].entireMemo
        } else {
            // 고정된 메모의 경우
            if indexPath.section == 0 {
                detailVC.searchedMemo = false
                detailVC.memoSequenceNumber = indexPath.row
                detailVC.memoSectionNumber = indexPath.section
                detailVC.textview.text = fixedMemoObject[indexPath.row].entireMemo
            } else {
                detailVC.searchedMemo = false
                detailVC.memoSequenceNumber = indexPath.row
                detailVC.memoSectionNumber = indexPath.section
                detailVC.textview.text = normalMemoObject[indexPath.row].entireMemo
            }
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
        if self.isFiltering == true {
            return filterdMemo?.count ?? 0
        } else {
            if section == 0 {
                return fixedMemoObject.count
            } else {
                return memoObject.count - fixedMemoObject.count
            }
        }
    }
    
    // 이제 여기서 섹션별 셀의 UI프로퍼티 설정 하면 됨
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemoListTableViewCell.identifier, for: indexPath) as! MemoListTableViewCell
        let memoObject = realm.objects(MemoObject.self)
        let fixedMemoObject = memoObject.where {
            $0.isFixed == "fixed"
        }
        let normalMemoObject = memoObject.where {
            $0.isFixed == "none"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd a hh:mm"
        
        if self.isFiltering == true {
            cell.memoTitleLabel.text = filterdMemo?[indexPath.row].memoTitle
            let memoDate = dateFormatter.string(from: filterdMemo?[indexPath.row].memoDate ?? Date())
            cell.memoWriteTimeLabel.text = memoDate
            cell.memodetailLabel.text = filterdMemo?[indexPath.row].memoDetail
        } else {
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
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //TODO: 여기서 서치바로 필터되면 1개 아니면, 섹션 별로 검색된 메모 표시하기
        if self.isFiltering == true {
            return 1
        } else {
            return 2
        }
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
