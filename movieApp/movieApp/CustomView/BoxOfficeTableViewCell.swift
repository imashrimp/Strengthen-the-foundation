//
//  MovieListTableViewCell.swift
//  movieApp
//
//  Created by 권현석 on 2023/05/23.
//

import UIKit
import SnapKit

class BoxOfficeTableViewCell: UITableViewCell {
    
    static let identifier = "BoxOfficeTableViewCell"
    
    let movieRankLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        return label
    }()
    
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "영화 제목"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let audienceNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "0명"
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
        [movieRankLabel, movieTitleLabel, audienceNumberLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func configure() {
        self.backgroundColor = .systemGray4
    }
    
    private func makeConstraints() {
        
        movieRankLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.top.bottom.equalToSuperview().inset(5)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        audienceNumberLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        audienceNumberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(movieTitleLabel.snp.trailing).inset(5)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
