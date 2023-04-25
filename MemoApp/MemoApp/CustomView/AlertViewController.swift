//
//  AlertViewController.swift
//  MemoApp
//
//  Created by 권현석 on 2023/04/21.
//

import UIKit
import SnapKit

class AlertView: UIView {
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "처음 오셨군요! 환영합니다 :)" // 이게 두 줄에 나눠서 나타나게
        label.numberOfLines = 0
        return label
    }()
    
    let introLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "당신만의 메모를 작성하고 관리해보세요!" // 이게 두 줄에 나눠서 나타나게
        label.numberOfLines = 0
        return label
    }()
    
    let confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange // 아니면 systemOrange
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        [welcomeLabel, introLabel, confirmButton].forEach {
            self.addSubview($0)
        }
    }
        
    private func makeConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(5)
        }
        
        introLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(5)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(introLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
