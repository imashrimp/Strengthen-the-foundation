//
//  BoxOfficeViewModel.swift
//  movieApp
//
//  Created by 권현석 on 2023/06/05.
//

import Foundation

protocol BoxOfficeRankProtocol: AnyObject {
    func saveBoxOfficeRank()
}

class BoxOfficeViewModel {
    
    weak var delegate: BoxOfficeRankProtocol?
    
    var boxOfficeAPINetworking = APINetworking()
    var boxOfficeRankData: [DailyBoxOfficeList] = []
    
    init() {
        boxOfficeAPINetworking.callBoxOfficeAPI { movies in
            self.boxOfficeRankData = movies.boxOfficeResult.dailyBoxOfficeList
            self.delegate?.saveBoxOfficeRank()
        }
    }
}
