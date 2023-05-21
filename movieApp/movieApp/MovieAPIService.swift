//
//  UserTarget.swift
//  movieApp
//
//  Created by 권현석 on 2023/05/20.
//

import Foundation
import Moya


// 여기서 api 호출하는거 같음
// 고려사항
// 날짜 최신화 방법

//enum MovieAPIService {
//  case getData(String, String)
//}
//
//extension MovieAPIService: TargetType {
//    var baseURL: URL {
//        // 이거 강제추출 하면 안 될건데? '??'이거 넣으면 뒤에 뭐 넣어야하지?
//        return URL(string: "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json")!
//    }
//
//    var path: String {
//        switch self {
//        case .getData(let keyCode, let targetDate):
//            return "?key=\(keyCode)&targetDT=\(targetDate)"
//        }
//    }
//
//    var method: Moya.Method {
//        switch self {
//        case .getData:
//            return .get
//        }
//    }
//
//    var sampleData: Data {
//        return Data()
//    }
//
//    var task: Moya.Task {
//        switch self {
//        case .getData:
//            return .requestPlain
//        }
//    }
//
//    var headers: [String : String]? {
//        return ["Content-Type:": "application/json"]
//    }
//}

enum BoxOfficeAPI {
    case dailyBoxOffice(date: String)
    // 다른 API 엔드포인트들을 추가할 수 있습니다.
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
            let params: [String: String] = ["targetDt": date]
            return .requestParameters(parameters: ["key": "84de47cdcc040f810cd24c330b8d8a9a", "targetDt": date], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
