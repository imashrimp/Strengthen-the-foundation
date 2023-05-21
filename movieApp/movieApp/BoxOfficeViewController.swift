//
//  ViewController.swift
//  movieApp
//
//  Created by 권현석 on 2023/05/20.
//

import UIKit
import SnapKit
import Moya

class BoxOfficeViewController: UIViewController {
    
    let date = Date()
    let dateFormatter = DateFormatter()
    
    let movieListTableView: UITableView = {
       let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let yesterdayByDate = Calendar.current.date(byAdding: .day, value: -1, to: date)
        dateFormatter.dateFormat = "yyyyMMdd"
        let yesterday = dateFormatter.string(from: yesterdayByDate ?? date)
        
        let provider = MoyaProvider<BoxOfficeAPI>()
        provider.request(.dailyBoxOffice(date: yesterday)) { result in
            switch result {
            case let .success(response):
                let result = try? response.map(Movie.self)
                print(result?.boxOfficeResult.dailyBoxOfficeList[0].movieNm ?? "")
            case let .failure(error):
                print("API CALL ERROR:\(error)")
            }
        }
    }
}

