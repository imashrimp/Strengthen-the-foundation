//
//  TableViewCell.swift
//  TableViewPractice
//
//  Created by 권현석 on 2023/04/18.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier = "ViewControllerCell"

    let imageview: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max")
//        translatesAutoresizingMaskIntoConstraints 이거는 뭐 하는거? => 이거를 false로 해야 셀 내부의 ui를 커스텀 할 수 있음
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let label: UILabel = {
       let label = UILabel()
        label.text = "레이블"
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        [imageview, label].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        imageview.snp.makeConstraints { make in
            make.top.leading.equalTo(5)
            make.height.width.equalTo(100)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(imageview.snp.trailing).offset(5)
            make.top.equalTo(5)
            make.trailing.equalTo(-5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
