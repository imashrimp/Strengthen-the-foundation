//
//  MovieListSectionHeaderView.swift
//  movieApp
//
//  Created by 권현석 on 2023/06/09.
//

import UIKit
import SnapKit

class MovieListSectionHeaderView: UIView {
    
    let movieTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "영화 제목"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()

    let genreLabel: UILabel = {
       let label = UILabel()
        label.text = "장르"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    let releaseDateLabel: UILabel = {
       let label = UILabel()
        label.text = "개봉일"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        self.addSubview(movieTitleLabel)
        self.addSubview(genreLabel)
        self.addSubview(releaseDateLabel)
    }
    
    private func makeConstraints() {
        movieTitleLabel.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(5)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
