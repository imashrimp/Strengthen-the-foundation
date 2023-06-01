//
//  UserTarget.swift
//  movieApp
//
//  Created by 권현석 on 2023/05/20.
//

import Foundation
import Moya

enum BoxOfficeAPI {
    case dailyBoxOffice(date: String)
    // 영화 제목을 한글 또는 영어로 검색했을 때 그 글자가 포함된 항목이 테이블 뷰에 나타나야함
    // 즉 아래의 케이스는 매개변수를 가져야하며, 해당 매개변수의 전달인자는 서치바를 통해 그 값을 받아올것임
    case movieList
    // 배우 이름을 한글 또는 영어로 검색했을 때 그 글자가 포함된 항목이 테이블 뷰에 나타나야함
    // 즉 아래의 케이스는 매개변수를 가져야하며, 해당 매개변수의 전달인자는 서치바를 통해 그 값을 받아올것임
    case actorList
}

extension BoxOfficeAPI: TargetType {
    var baseURL: URL {
        let urlString: String = "https://www.kobis.or.kr"
        guard let url = URL(string: urlString) else { fatalError()}
        return url
    }
    
    var path: String {
        switch self {
        case .dailyBoxOffice:
            return "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        case .movieList:
            return "/kobisopenapi/webservice/rest/movie/searchMovieList.json"
        case .actorList:
            return "/kobisopenapi/webservice/rest/people/searchPeopleList.json"
        }
    }
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .dailyBoxOffice(let date):
            return .requestParameters(parameters: ["key": "84de47cdcc040f810cd24c330b8d8a9a", "targetDt": date], encoding: URLEncoding.default)
        case .movieList:
            return .requestParameters(parameters: ["key": "84de47cdcc040f810cd24c330b8d8a9a"], encoding: URLEncoding.default)
        case .actorList:
            return .requestParameters(parameters: ["key": "84de47cdcc040f810cd24c330b8d8a9a", "itemPerPage": "100"], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
