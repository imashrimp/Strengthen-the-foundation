//
//  ViewController.swift
//  movieApp
//
//  Created by 권현석 on 2023/05/20.
//

import UIKit
import SnapKit
import Moya

class BoxOfficeViewController: UIViewController {
    
    var boxOfficeAPINetworking = APINetworking()
    var boxOfficeViewModel = BoxOfficeViewModel()
    
    let sectionHeaderView = BoxOfficeSectionHeaderView()
    let boxOfficeTableView: UITableView = {
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
        
        boxOfficeViewModel.delegate = self
        
        addSubViews()
        configure()
        makeConstraints()
    }
    
    private func addSubViews() {
        [sectionHeaderView, boxOfficeTableView, searchMovieButton, searchActorButton].forEach {
            self.view.addSubview($0)
        }
    }
    
    private func configure() {
        boxOfficeTableView.dataSource = self
        boxOfficeTableView.delegate = self
        buttonConfigure()
        setNavigationTitle()
    }
    
    private func makeConstraints() {
        boxOfficeTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().offset(5)
        }
        
        searchMovieButton.snp.makeConstraints { make in
            make.top.equalTo(boxOfficeTableView.snp.bottom).offset(30)
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

//MARK: - 델리게이트 활용 익스텐션
extension BoxOfficeViewController: BoxOfficeRankProtocol {
    func saveBoxOfficeRank() {
        if boxOfficeViewModel.boxOfficeRankData.isEmpty == false {
            self.boxOfficeTableView.reloadData()
        }
    }
}

extension BoxOfficeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = BoxOfficeSectionHeaderView()
        return header
    }
}

extension BoxOfficeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeViewModel.boxOfficeRankData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoxOfficeTableViewCell", for: indexPath) as! BoxOfficeTableViewCell
        
        let item = self.boxOfficeViewModel.boxOfficeRankData[indexPath.row]
        
        cell.movieRankLabel.text = item.rank
        cell.movieTitleLabel.text = item.movieNm
        cell.audienceNumberLabel.text = "\(item.audiAcc)명"
        
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
        self.navigationItem.title = "일간 박스오피스"
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
