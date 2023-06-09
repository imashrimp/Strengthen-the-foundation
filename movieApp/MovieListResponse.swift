//
//  MovieListResponse.swift
//  movieApp
//
//  Created by 권현석 on 2023/05/23.
//

import Foundation

// MARK: - MovieList
struct MovieList: Codable {
    let movieListResult: MovieListResult
}

// MARK: - MovieListResult
struct MovieListResult: Codable {
    let totCnt: Int
    let source: String
    let movieList: [MovieListElement]
}

// MARK: - MovieListElement
struct MovieListElement: Codable {
    let movieNm, movieNmEn, openDt: String
    let repGenreNm: String
}
