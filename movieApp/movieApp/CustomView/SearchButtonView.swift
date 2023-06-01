//
//  SearchButtonView.swift
//  movieApp
//
//  Created by 권현석 on 2023/06/01.
//

import UIKit
import SnapKit

class SearchButtonView: UIView {

    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("검색", for: .normal)
        return button
    }()

    private func addSubviews() {
        self.addSubview(searchButton)
    }
    
    private func configure() {
        
    }
    
    private func makeConstraints() {
        searchButton.snp.makeConstraints { make in
            make.centerY.centerY.equalToSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configure()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
