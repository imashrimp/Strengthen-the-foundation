//
//  CustomView.swift
//  MemoApp
//
//  Created by 권현석 on 2023/04/21.
//
import Foundation
import UIKit
import SnapKit

class CustomView: UIView {
    
    let memoCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0개의 메모"
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 35, weight: .bold)
        return label
    }()
    
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색"
        searchBar.setImage(UIImage(systemName: "magnifyingglass"), for: UISearchBar.Icon.search, state: .normal)
        // 이거 취소로 바꿔야함
        searchBar.setImage(UIImage(systemName: "xmark"), for: .clear, state: .normal)
        searchBar.barTintColor = .black
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = .systemGray
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            textfield.textColor = UIColor.white
            
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.white
            }
            if let rightView = textfield.rightView as? UIImageView {
                rightView.image = rightView.image?.withRenderingMode(.alwaysTemplate)
                rightView.tintColor = UIColor.white
            }
        }
        return searchBar
    }()
    
    let tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableview.backgroundColor = .black
        return tableview
    }()
    
//    let createMemoButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
//        button.addTarget(CustomView.self, action: #selector(ViewController.createNewMemo), for: .touchDown)
//        button.tintColor = .systemOrange
//        button.backgroundColor = .black
//        // 버튼 이미지 얼라이먼트 해야함
//
//        return button
//    }()
    
    let verticalStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 10
        return stackview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        makeConstraints()
    }
    
    private func addSubViews() {
        verticalStackView.addArrangedSubview(searchBar)
        verticalStackView.addArrangedSubview(tableView)
//        verticalStackView.addArrangedSubview(createMemoButton)
    }
    
    // 이게 겉보기에 leading trailing빼고는 별 의미 없는거 같기도?
    private func makeConstraints() {
        searchBar.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(10)
//            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
//            make.top.equalTo(searchBar.snp.bottom).offset(20)
//            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // 이거는 스택뷰 외부에서 한 번 더 넣어보고 차이를 찾은 다음 그래도 모르면 물어보자
//        createMemoButton.snp.makeConstraints { make in
//            make.top.equalTo(tableView.snp.bottom).offset(10)
//            make.trailing.equalToSuperview().inset(20)
//            make.height.width.equalTo(50)
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
