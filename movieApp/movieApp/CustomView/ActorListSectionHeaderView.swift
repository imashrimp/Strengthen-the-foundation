//
//  ActorListSectionHeaderView.swift
//  movieApp
//
//  Created by 권현석 on 2023/06/09.
//

import UIKit
import SnapKit

class ActorListSectionHeaderView: UIView {
    
    let actorNameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    let filmoLabel: UILabel = {
        let label = UILabel()
        label.text = "필모그래피"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        makeConstraints()
    }
    
    private func addSubViews() {
        self.addSubview(actorNameLabel)
        self.addSubview(filmoLabel)
    }
    
    private func makeConstraints() {
        actorNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.top.bottom.equalToSuperview().inset(5)
            make.width.equalTo(120)
        }
        
        filmoLabel.snp.makeConstraints { make in
            make.leading.equalTo(actorNameLabel.snp.trailing).offset(50)
            make.top.trailing.bottom.equalToSuperview().inset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
