//
//  MovieListViewController.swift
//  movieApp
//
//  Created by 권현석 on 2023/05/22.
//

import UIKit
import SnapKit
import Moya

class MovieListViewController: UIViewController {
    
    let viewModel = MovieListViewModel()
    
    let searchBar: UISearchController = UISearchController(searchResultsController: nil)
    let movieListTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.identifier)
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieListTableView.dataSource = self
        movieListTableView.delegate = self
        
        addSubViews()
        configure()
        makeConstraints()
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
extension MovieListViewController {
    
    private func setNavBar() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.title = "영화 목록"
        self.navigationItem.searchController = searchBar
        setSearchBar()
    }
    
    private func setSearchBar() {
        searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.searchResultsUpdater = self
        searchBar.automaticallyShowsCancelButton = true
        searchBar.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchBar.searchBar.placeholder = "영화 제목을 입력하세요."
    }
}


extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchKeyword = searchController.searchBar.text ?? ""
        
        viewModel.movieListAPICall {
            self.movieListTableView.reloadData()
        }
    }
}

//MARK: - 테이블 뷰 델리게이트, 데이터 소스
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = MovieListSectionHeaderView()
        return header
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredMovieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as! MovieListTableViewCell
        
        cell.krMovieTitleLabel.text = self.viewModel.filteredMovieList[indexPath.row].movieNm
        cell.enMovieTitleLabel.text = self.viewModel.filteredMovieList[indexPath.row].movieNmEn
        cell.genreLabel.text = self.viewModel.filteredMovieList[indexPath.row].repGenreNm
        cell.releaseDateLabel.text = self.viewModel.filteredMovieList[indexPath.row].openDt
        
        return cell
    }
}
