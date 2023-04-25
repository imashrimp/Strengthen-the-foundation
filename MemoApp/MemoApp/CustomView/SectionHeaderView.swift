//
//  SectionHeaderView.swift
//  MemoApp
//
//  Created by 권현석 on 2023/04/23.
//

import UIKit

class SectionHeaderView: UIView {

    let headerLabel: UILabel = {
       let label = UILabel()
        label.text = "" // 고정된 메모던 그냥 메모이던 뷰를 불러와서 이 프로퍼티를 바꾸면 될 듯?
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .left
        label.textColor = .white
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.addSubview(headerLabel)
    }
    
    private func makeConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.top.equalToSuperview().offset(10)
        }
    }
}
