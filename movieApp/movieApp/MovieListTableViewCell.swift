//
//  MovieListTableViewCell.swift
//  movieApp
//
//  Created by 권현석 on 2023/05/21.
//

import UIKit
import SnapKit

class MovieListTableViewCell: UITableViewCell {
    
    static let identifier = "MovieListTableViewCell"
    
    /// 박스오피스 순위 레이블
    let movieRankLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let movieTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "영화 제목"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let audiencNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "0명"
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()

    
    
    private func addSubViews() {
        [movieRankLabel, movieTitleLabel, audiencNumberLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func configure() {
        self.backgroundColor = .lightGray
    }
    
    private func makeConstraints() {
        movieRankLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(5)
            // 이거 맞나 모르겠음. 목적은 가로축을 기준으로 가운데 놓으려고 한거임
            make.centerY.equalToSuperview()
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(movieRankLabel.snp.trailing).offset(5)
            make.top.equalToSuperview().offset(5)
        }
        
        audiencNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(movieTitleLabel.snp.trailing).offset(5)
            make.top.trailing.equalToSuperview().inset(5)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
