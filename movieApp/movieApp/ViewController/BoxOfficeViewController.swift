//
//  ViewController.swift
//  movieApp
//
//  Created by 권현석 on 2023/05/20.
//

//TODO: 버튼 커스텀뷰랑 테이블뷰 레이아웃 해결
// api 호출 데이터 클로저 밖으로 가져오는거 해결
// 새로운 api 호출(영화 api, 배우 api)

import UIKit
import SnapKit
import Moya

class BoxOfficeViewController: UIViewController {

    
    /// api 호출 클래스 인스턴스
    var boxOfficeAPINetworking = APINetworking()
    
    let sectionHeaderView = SectionHeaderView()
    let movieListTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)
        return tableview
    }()
    let searchMovieButton: UIButton = UIButton()
    let searchActorButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        addSubViews()
        configure()
        makeConstraints()
    }
    
    private func addSubViews() {
        [sectionHeaderView, movieListTableView, searchMovieButton, searchActorButton].forEach {
            self.view.addSubview($0)
        }
    }
    
    private func configure() {
        movieListTableView.dataSource = self
        movieListTableView.delegate = self
        buttonConfigure()
        setNavigationTitle()
    }
    
    private func makeConstraints() {
        movieListTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().offset(5)
        }
        
        searchMovieButton.snp.makeConstraints { make in
            make.top.equalTo(movieListTableView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        searchActorButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(searchMovieButton.snp.bottom).offset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
}

extension BoxOfficeViewController: UITableViewDelegate {
    
    /// 섹션 헤더 나타내는 메서드
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SectionHeaderView()
        return header
    }
}

extension BoxOfficeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoxOfficeTableViewCell", for: indexPath) as! BoxOfficeTableViewCell
        
        boxOfficeAPINetworking.callBoxOfficeAPI { movies in
            DispatchQueue.main.async {
                cell.movieRankLabel.text = movies.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rank
                cell.movieTitleLabel.text = movies.boxOfficeResult.dailyBoxOfficeList[indexPath.row].movieNm
                cell.audienceNumberLabel.text = "\(movies.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audiAcc)명"
            }
        }
        return cell
    }
}

//MARK: - 버튼 설정 및 푸쉬 메서드
extension BoxOfficeViewController {
    
    private func buttonConfigure() {
        searchMovieButton.layer.cornerRadius = 8
        searchMovieButton.setTitle("영화 찾기", for: .normal)
        searchMovieButton.setTitleColor(.white, for: .normal)
        searchMovieButton.backgroundColor = .systemOrange
        searchMovieButton.addTarget(self, action: #selector(pushToMovieListVC), for: .touchUpInside)
        
        searchActorButton.layer.cornerRadius = 8
        searchActorButton.setTitle("배우 찾기", for: .normal)
        searchActorButton.setTitleColor(.white, for: .normal)
        searchActorButton.backgroundColor = .systemOrange
        searchActorButton.addTarget(self, action: #selector(pushToActorListVC), for: .touchUpInside)
    }
    
    private func setNavigationTitle() {
        boxOfficeAPINetworking.callBoxOfficeAPI { movies in
            self.navigationItem.title = movies.boxOfficeResult.boxofficeType
        }
    }
    
    @objc func pushToMovieListVC() {
        let vc = MovieListViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pushToActorListVC() {
        let vc = ActorListViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
