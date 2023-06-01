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
    
    var searchKeyword: String = ""
    var wholeMovieResult: MovieListResult?
    var filteredMovieList: [MovieListElement] = []
    let movieListAPINetworking = APINetworking()
    
    let searchBar: UISearchController = UISearchController(searchResultsController: nil)
    let searchButtonView: UIView = SearchButtonView()
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
        
        saveAPIData()
    }

    private func addSubViews() {
        self.view.addSubview(movieListTableView)
        self.view.addSubview(searchButtonView)
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
        self.navigationItem.title = "영화 목록"
        self.navigationItem.searchController = searchBar
        setSearchBar()
    }
    
    private func setSearchBar() {
        searchBar.searchBar.placeholder = "영화 제목을 입력하세요."
        searchBar.automaticallyShowsCancelButton = false
        searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.searchResultsUpdater = self
    }
}

//MARK: - api 호출 후 데이터를 프로퍼티에 저장하는 메서드 작성 익스텐션
extension MovieListViewController {
    
    /// "검색" 버튼에 등록할 메서드
    @objc func searchButtonTapped() {
        print("검색 버튼이 눌러졌을 때 검색어는 \(searchKeyword)입니다.")
       filteredMovieList = wholeMovieResult?.movieList.filter {
           $0.movieNm.contains(searchKeyword)
       } ?? []
        print("버튼이 눌러질 때 걸러진 영화 목록: \(filteredMovieList)")
        movieListTableView.reloadData()
    }
    
    private func saveAPIData() {
        movieListAPINetworking.callMovieListAPI { movie in
            self.wholeMovieResult = movie.movieListResult
        }
    }
}

extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchKeyword = searchController.searchBar.text ?? ""
        print(searchKeyword)
    }
}

//MARK: - 테이블 뷰 델리게이트, 데이터 소스
extension MovieListViewController: UITableViewDelegate {
    
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredMovieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as! MovieListTableViewCell
        
        DispatchQueue.main.async {
            cell.krMovieTitleLabel.text = self.filteredMovieList[indexPath.row].movieNm
            cell.enMovieTitleLabel.text = self.filteredMovieList[indexPath.row].movieNmEn
            cell.genreLabel.text = self.filteredMovieList[indexPath.row].repGenreNm
            cell.directorNameLabel.text = self.filteredMovieList[indexPath.row].directors[0].peopleNm
            cell.releaseDateLabel.text = self.filteredMovieList[indexPath.row].openDt
        }
        return cell
    }
}
