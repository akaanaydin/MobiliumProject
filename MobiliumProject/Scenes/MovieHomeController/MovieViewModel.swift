//
//  MovieViewModel.swift
//  MobiliumProject
//
//  Created by Arslan Kaan AYDIN on 19.06.2022.
//

import Foundation
import Alamofire

protocol MovieViewModelProtocol {
    func fetchUpComingMovies(onSuccess: @escaping (UpComingMovieModel?) -> Void, onError: @escaping (AFError) -> Void)
    func fetchNowPlayingMovies(onSuccess: @escaping (NowPlayingMovieModel?) -> Void, onError: @escaping (AFError) -> Void)
    func getMovieDetail(movieID: Int, onSuccess: @escaping (MovieDetailModel?) -> Void, onError: @escaping (AFError) -> Void)
        var delegate: MovieOutput? { get set }
}

final class MovieViewModel: MovieViewModelProtocol {
        var delegate: MovieOutput?
    
    private var service: ServicesProtocol
    
    init(service: ServicesProtocol) {
        self.service = service
    }
    
}

extension MovieViewModel {
    func fetchUpComingMovies(onSuccess: @escaping (UpComingMovieModel?) -> Void, onError: @escaping (AFError) -> Void) {
        service.fetchUpComingMovies { movie in
            guard let movie = movie else {
                onSuccess(nil)
                return
            }
            onSuccess(movie)
        } onError: { error in
            onError(error)
        }
        
    }
    
    func fetchNowPlayingMovies(onSuccess: @escaping (NowPlayingMovieModel?) -> Void, onError: @escaping (AFError) -> Void) {
        service.fetchNowPlayingMovies { movie in
            guard let movie = movie else {
                onSuccess(nil)
                return
            }
            onSuccess(movie)
        } onError: { error in
            onError(error)
        }
        
    }
    
    func getMovieDetail(movieID: Int, onSuccess: @escaping (MovieDetailModel?) -> Void, onError: @escaping (AFError) -> Void) {
        service.getMovieDetail(movieID: movieID) { movieDetail in
            guard let movieDetail = movieDetail else {
                onSuccess(nil)
                return
            }
            onSuccess(movieDetail)
        } onError: { error in
            onError(error)
        }

    }
}
