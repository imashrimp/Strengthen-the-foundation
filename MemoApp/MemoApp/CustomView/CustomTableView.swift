//
//  CustomView.swift
//  MemoApp
//
//  Created by 권현석 on 2023/04/21.
//
import Foundation
import UIKit
import SnapKit

class CustomTableView: UIView {

    let tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return tableview
    }()
}
