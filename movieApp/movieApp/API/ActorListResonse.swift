//
//  ActorListResonse.swift
//  movieApp
//
//  Created by 권현석 on 2023/05/23.
//

import Foundation

// MARK: - ActorList
struct ActorList: Codable {
    let peopleListResult: PeopleListResult
}

// MARK: - PeopleListResult
struct PeopleListResult: Codable {
    let totCnt: Int
    let peopleList: [PeopleList]
}

// MARK: - PeopleList
struct PeopleList: Codable {
    let peopleNm, peopleNmEn, filmoNames: String
}
