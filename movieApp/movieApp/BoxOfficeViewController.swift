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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let provider = MoyaProvider<BoxOfficeAPI>()
        provider.request(.dailyBoxOffice(date: "20230520")) { result in
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

