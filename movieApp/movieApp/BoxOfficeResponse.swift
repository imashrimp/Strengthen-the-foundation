//
//  ResponseData.swift
//  movieApp
//
//  Created by 권현석 on 2023/05/21.
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let rank: String
    let movieNm: String
    let openDt: String
    let audiAcc: String
}
