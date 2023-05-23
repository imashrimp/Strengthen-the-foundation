//
//  MovieListTableViewCell.swift
//  movieApp
//
//  Created by 권현석 on 2023/05/23.
//

import UIKit
import SnapKit

class MovieListTableViewCell: UITableViewCell {
    
    static let identifier = "MovieListTableViewCell"
    
    let krMovieTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "영화 제목"
        label.textAlignment = .left
        return label
    }()
    
    let enMovieTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "movie title"
        label.textAlignment = .left
        return label
    }()
    
    let genreLabel: UILabel = {
       let label = UILabel()
        label.text = "영화 장르"
        label.textAlignment = .center
        return label
    }()
    
    let directorNameLabel: UILabel = {
       let label = UILabel()
        label.text = "감독 이름"
        label.textAlignment = .center
        return label
    }()
    
    let releaseDateLabel: UILabel = {
       let label = UILabel()
        label.text = "개봉일"
        label.textAlignment = .right
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        configure()
        makeConstraints()
    }
    
    private func addSubViews() {
        [krMovieTitleLabel, enMovieTitleLabel, genreLabel, directorNameLabel, releaseDateLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func configure() {
        self.backgroundColor = .systemGray4
    }
    
    private func makeConstraints() {
        
        krMovieTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(5)
        }
        
        enMovieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(krMovieTitleLabel.snp.bottom).offset(2)
            make.leading.bottom.equalToSuperview().inset(5)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(krMovieTitleLabel.snp.trailing).offset(5)
        }
        
        directorNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(genreLabel.snp.trailing).offset(5)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
