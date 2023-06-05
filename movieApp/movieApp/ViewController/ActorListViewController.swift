//
//  ActorListViewController.swift
//  movieApp
//
//  Created by 권현석 on 2023/05/22.
//

import UIKit

class ActorListViewController: UIViewController {
    
    var wholeActorResult: PeopleListResult?
    var filteredActorList: [PeopleList] = []
    var searchKeyword: String = ""
    
    let actorListAPINetworking = APINetworking()
    
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
        
        callAPI()
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
        searchKeyword = searchController.searchBar.text ?? ""
        filteredActorList = wholeActorResult?.peopleList.filter {
            $0.peopleNm.contains(searchKeyword )
        } ?? []
        self.actorListTableView.reloadData()
    }
    
    private func setSearchBar() {
        searchBar.searchBar.placeholder = "배우 이름을 검색하세요"
        searchBar.automaticallyShowsCancelButton = true
        searchBar.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchBar.searchResultsUpdater = self
    }
}

//MARK: - api 호출 익스텐션
extension ActorListViewController {
    private func callAPI() {
        actorListAPINetworking.callActorListAPI { actors in
            self.wholeActorResult = actors.peopleListResult
        }
    }
}

//MARK: - 테이블 뷰 익스텐션
extension ActorListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension ActorListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("검색된 배우는 \(filteredActorList.count)명 입니다.")
        return filteredActorList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActorListTableViewCell", for: indexPath) as! ActorListTableViewCell
        
        DispatchQueue.main.async {
            cell.actorNameKrLabel.text = self.filteredActorList[indexPath.row].peopleNm
            cell.actorNameEnLabel.text = self.filteredActorList[indexPath.row].peopleNmEn
            cell.filmographyLabel.text = self.filteredActorList[indexPath.row].filmoNames
        }
        
        return cell
    }
}
