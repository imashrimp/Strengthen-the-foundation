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
    
    let nameView: UIView = UIView()
    let filmoView: UIView = UIView()
    
    let actorNameKrLabel: UILabel = {
        let label = UILabel()
        label.text = "배우 이름"
        label.textAlignment = .center
        return label
    }()
    
    let actorNameEnLabel: UILabel = {
        let label = UILabel()
        label.text = "actor's name"
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.3
        return label
    }()
    
    let filmographyLabel: UILabel = {
        let label = UILabel()
        label.text = "필모그래피"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        configure()
        makeConstrints()
    }
    
    private func addSubViews() {
        [actorNameKrLabel, actorNameEnLabel].forEach {
            nameView.addSubview($0)
        }
        
        [filmographyLabel].forEach {
            filmoView.addSubview($0)
        }
        
        [nameView, filmoView].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func configure() {
        self.backgroundColor = .systemGray4
    }
    
    private func makeConstrints() {
        nameView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(100)
        }
        
        actorNameKrLabel.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview()
            make.leading.trailing.equalToSuperview().inset(5)
            
        }
        
        actorNameEnLabel.snp.makeConstraints { make in
            make.top.equalTo(actorNameKrLabel.snp.bottom).offset(2)
            make.leading.bottom.trailing.equalToSuperview().inset(5)
        }
        
        filmoView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(nameView.snp.trailing).offset(20)
        }
        
        filmographyLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
