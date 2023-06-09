//
//  ActorListViewController.swift
//  movieApp
//
//  Created by 권현석 on 2023/05/22.
//

import UIKit

class ActorListViewController: UIViewController {
    
    let viewModel = ActorListViewModel()
    
    let searchBar = UISearchController(searchResultsController: nil)
    let actorListTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(ActorListTableViewCell.self, forCellReuseIdentifier: ActorListTableViewCell.identifier)
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        actorListTableView.delegate = self
        actorListTableView.dataSource = self
        
        addSubViews()
        configure()
        makeConstraints()
    }
    
    private func addSubViews() {
        self.view.addSubview(actorListTableView)
    }
    
    private func configure() {
        self.view.backgroundColor = .white
        setNavBar()
        setSearchBar()
    }
    
    private func makeConstraints() {
        actorListTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - 네비게이션바 익스텐션
extension ActorListViewController {
    private func setNavBar() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.title = "배우 목록"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchBar
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

//MARK: - 서치바 익스텐션
extension ActorListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchKeyword = searchController.searchBar.text ?? ""
        viewModel.actorAPICall {
            self.actorListTableView.reloadData()
        }
    }
    
    private func setSearchBar() {
        searchBar.searchBar.placeholder = "배우 이름을 검색하세요"
        searchBar.automaticallyShowsCancelButton = true
        searchBar.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchBar.searchResultsUpdater = self
    }
}

//MARK: - 테이블 뷰 익스텐션
extension ActorListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ActorListSectionHeaderView()
        return header
    }
}

extension ActorListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredActorList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActorListTableViewCell", for: indexPath) as! ActorListTableViewCell
        
        let item = self.viewModel.filteredActorList[indexPath.row]
        
        cell.actorNameKrLabel.text = item.peopleNm
        cell.actorNameEnLabel.text = item.peopleNmEn
        cell.filmographyLabel.text = item.filmoNames
        
        return cell
    }
}
