//
//  MovieListViewController.swift
//  movieApp
//
//  Created by 권현석 on 2023/05/22.
//

//TODO: 1. 테이블 뷰 넣기, 테이블뷰 셀 만들기
// 서치바 텍스트를 입력하면 그에 따른 api호출이 되어서 호출된 데이터가 셀에 표시되도록

import UIKit
import SnapKit
import Moya

class MovieListViewController: UIViewController {
    
    var filteredMovie: MovieList?
    var searchKeyword: String?
    var movieListCollection: [MovieListElement] = [] // 아니면 옵셔널로
    
    let movieListAPINetworking = APINetworking()
    var movieCount: Int?
    
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
        
        movieListTableView.dataSource = self
        movieListTableView.delegate = self
        
        movieListAPINetworking.callMovieListAPI { movie in
            self.movieCount = movie.movieListResult.movieList.count
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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

//MARK: - api 호출 후 데이터를 프로퍼티에 저장하는 메서드 작성 익스텐션
extension MovieListViewController {
    
    private func saveAPIData() {
        movieListAPINetworking.callMovieListAPI { movie in
            self.movieListCollection = movie.movieListResult.movieList
        }
    }
}

extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchKeyword = searchController.searchBar.text
        dump(movieListCollection)
        let condition: ((String, String)) -> Bool = {
            $0.0.contains(self.searchKeyword ?? "")
        }
        
        
        
//        print("서치바에 입련된 텍스트는 \(searchKeyword)입니다.")
//        print("서치바에서 movieCount의 값은 \(movieCount)입니다.")
    }
}

//MARK: - 테이블 뷰 델리게이트, 데이터 소스
extension MovieListViewController: UITableViewDelegate {
    
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        movieListAPINetworking.callMovieListAPI { movie in
//            self.movieCount = movie.movieListResult.movieList.count
//            print("클로저 내부에서의 값: \(self.movieCount)")
//        }
//        print("클로저 밖에서의 값: \(movieCount)")
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as! MovieListTableViewCell
        
        movieListAPINetworking.callMovieListAPI { movie in
            cell.krMovieTitleLabel.text = movie.movieListResult.movieList[indexPath.row].movieNm
//            self.movieCount = movie.movieListResult.movieList.count
            print(movie.movieListResult.movieList[indexPath.row].movieNm)
//            print("TEST1: \(self.movieCount)")
        }
//        print("TEST2: \(movieCount)")
        return cell
    }
}

// 1. 첫 번째로 서치바에 입력된 텍스트를 가져온다. => 해당 스트링 값을 저장할 저장소 필요
// 2. 입력된 텍스트를 사용해 api 호출된 데이터를 필터링한다. => 검색어 저장소를 사용해 필터링된 데이터를 저장할 저장소 필요
// 3. 필터링 된 데이터를 사용해 셀 갯수 표시와 셀의 형태를 나타낸다. => 필터링된 데이터 사용해 나타낼 셀의 갯수와 셀 형태 나타내기
