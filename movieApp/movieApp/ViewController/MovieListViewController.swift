//
//  MovieListViewController.swift
//  movieApp
//
//  Created by 권현석 on 2023/05/22.
//

//TODO: 1. 서치바 넣기, 테이블 뷰 넣기, 테이블뷰 셀 만들기
// 서치바 텍스트를 입력하면 그에 따른 api호출이 되어서 호출된 데이터가 셀에 표시되도록

import UIKit
import SnapKit
import Moya

class MovieListViewController: UIViewController {

    let movieListAPINetworking = APINetworking()
    
    let searchBar: UISearchController = UISearchController(searchResultsController: nil)
    let movieListTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.identifier)
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configure()
        makeConstraints()
        
//        movieListTableView.dataSource = self
        movieListTableView.delegate = self
        
        movieListAPINetworking.callMovieListAPI { movie in
            print(movie.movieListResult.movieList[0].movieNm)
        }
    }
    
    private func addSubViews() {
        self.view.addSubview(movieListTableView)
    }
    
    private func configure() {
        self.view.backgroundColor = .white
        setNavBar()
    }
    
    private func makeConstraints() {
        movieListTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - 네비게이션바 및 서치바
extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        <#code#>
    }
    
    
    private func setNavBar() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "영화 목록"
        self.navigationItem.searchController = searchBar
        setSearchBar()
    }
    
    private func setSearchBar() {
        searchBar.searchBar.placeholder = "영화 제목을 입력하세요."
        searchBar.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchBar.automaticallyShowsCancelButton = true
        searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.searchResultsUpdater = self
    }
}

//MARK: - 테이블 뷰 델리게이트, 데이터 소스
extension MovieListViewController: UITableViewDelegate {
    
}

//extension MovieListViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//}
