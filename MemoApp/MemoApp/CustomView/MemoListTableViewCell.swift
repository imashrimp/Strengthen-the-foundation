//
//  TableViewCell.swift
//  MemoApp
//
//  Created by 권현석 on 2023/04/23.
//

// 작성시간 레이블, 세부내용 레이블을 스택뷰에 넣어서 뷰를 등록함 => 해당 두 레이블은 등록하지 않고, 스택뷰만 등록함

import UIKit
import SnapKit

class MemoListTableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"
    
    let memoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "메모 제목"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    let memoWriteTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "메모 작성 시간"
        label.textColor = .systemGray
        label.textAlignment = .left
        return label
    }()
    
    let memodetailLabel: UILabel = {
        let label = UILabel()
        label.text = "메모 내용"
        label.textColor = .systemGray
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        configure()
        makeConstraints()
    }
    
    private func addSubViews() {
        [memoTitleLabel, memoWriteTimeLabel, memodetailLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func configure() {
        self.backgroundColor = .darkGray
    }
    
    private func makeConstraints() {
        memoTitleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(5)
        }
        
        memoWriteTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(memoTitleLabel.snp.bottom).offset(5)
            make.leading.bottom.equalToSuperview().inset(5)
        }
        
        memodetailLabel.snp.makeConstraints { make in
            make.top.equalTo(memoTitleLabel.snp.bottom).offset(5)
            make.leading.equalTo(memoWriteTimeLabel.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(5).priority(.low) // trailing이 superview를 뚫고 나온다.
            make.bottom.equalToSuperview().inset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
