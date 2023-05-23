//
//  ActorListViewController.swift
//  movieApp
//
//  Created by 권현석 on 2023/05/22.
//

import UIKit

class ActorListViewController: UIViewController {

    let actorListTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
//        tableview.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.identifier)
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        actorListTableView.delegate = self
//        actorListTableView.dataSource = self
        
    }
    
    private func addSubViews() {
        
    }
    
    private func makeConstraints() {
        
    }
}

extension ActorListViewController: UITableViewDelegate {
    
}

//extension ActorListViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//}
