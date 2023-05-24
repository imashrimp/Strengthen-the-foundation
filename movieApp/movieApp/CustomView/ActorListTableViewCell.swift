//
//  ActorListTableViewCell.swift
//  movieApp
//
//  Created by 권현석 on 2023/05/23.
//

import UIKit
import SnapKit

class ActorListTableViewCell: UITableViewCell {
    
    static let identifier = "ActorListTableViewCell"
    
    let actorNameKrLabel: UILabel = {
       let label = UILabel()
        label.text = "배우 이름"
        label.textAlignment = .left
        return label
    }()
    
    let actorNameEnLabel: UILabel = {
       let label = UILabel()
        label.text = "actor's name"
        label.textAlignment = .left
        return label
    }()
    
    let filmographyLabel: UILabel = {
       let label = UILabel()
        label.text = "필모그래피"
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    private func addSubViews() {
        [actorNameKrLabel, actorNameEnLabel, filmographyLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func configure() {
        self.backgroundColor = .systemGray4
    }
    
    private func makeConstrints() {
        actorNameKrLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(5)
        }
        
        actorNameEnLabel.snp.makeConstraints { make in
            make.top.equalTo(actorNameKrLabel.snp.bottom).offset(2)
            make.leading.bottom.equalToSuperview().inset(5)
        }
        
        filmographyLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
