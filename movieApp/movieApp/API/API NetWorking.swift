//
//  API NetWorking.swift
//  movieApp
//
//  Created by 권현석 on 2023/05/22.
//

import Foundation
import Moya

class APINetworking {
    
    var provider = MoyaProvider<BoxOfficeAPI>()
    let date = Date()
    let dateFormatter = DateFormatter()
    
    /// 박스오피스 api호출 메서드
    func callBoxOfficeAPI(completion: @escaping (BoxOffice) -> Void) {
        let yesterdayByDate = Calendar.current.date(byAdding: .day, value: -1, to: date)
        dateFormatter.dateFormat = "yyyyMMdd"
        let yesterday = dateFormatter.string(from: yesterdayByDate ?? date)
        
        provider.request(.dailyBoxOffice(date: yesterday)) { result in
            switch result {
            case let .success(response):
                guard let result = try? response.map(BoxOffice.self) else { return }
                completion(result)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    /// 영화 목록 api 호출 메서드
    func callMovieListAPI(keyword: String, completion: @escaping (MovieList) -> Void) {
        
        provider.request(.movieList(movieTitle: keyword)) { result in
            switch result {
            case let .success(response):
                guard let result = try? response.map(MovieList.self) else { return }
                completion(result)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    /// 영화 배우 api 호출 메서드
    func callActorListAPI(keyword: String, comletion: @escaping (ActorList) -> Void) {
        
        provider.request(.actorList(actorName: keyword)) { result in
            switch result {
            case let .success(response):
                guard let result = try? response.map(ActorList.self) else { return }
                comletion(result)
            case let .failure(error):
                print(error)
            }
        }
    }
}

