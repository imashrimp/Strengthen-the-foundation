//
//  MovieListViewModel.swift
//  movieApp
//
//  Created by 권현석 on 2023/06/08.
//

import Foundation

class MovieListViewModel {
    var searchKeyword: String = ""
    var filteredMovieList: [MovieListElement] = []
    let movieListAPINetworking = APINetworking()
    
    func movieListAPICall(completion: @escaping () -> Void) {
        movieListAPINetworking.callMovieListAPI(keyword: searchKeyword) { movie in
            self.filteredMovieList = movie.movieListResult.movieList
            completion()
        }
    }
}
