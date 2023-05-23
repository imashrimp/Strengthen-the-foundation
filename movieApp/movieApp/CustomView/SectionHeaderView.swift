//
//  SearchButtonUIView.swift
//  movieApp
//
//  Created by 권현석 on 2023/05/22.
//

import UIKit
import SnapKit

class SectionHeaderView: UIView {
    
    let rankHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "순위"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        
        return label
    }()
    
    let movieTitleHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "영화 제목"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    let audienceNumberHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "누적 관객수"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        makeConstraints()
    }
    
    private func addSubViews() {
        self.addSubview(rankHeaderLabel)
        self.addSubview(movieTitleHeaderLabel)
        self.addSubview(audienceNumberHeaderLabel)
    }
    
    private func makeConstraints() {
        rankHeaderLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.top.bottom.equalToSuperview().inset(5)
        }
        
        movieTitleHeaderLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        audienceNumberHeaderLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
