//
//  Service.swift
//  MobiliumProject
//
//  Created by Arslan Kaan AYDIN on 19.06.2022.
//

import Foundation
import Alamofire

//MARK: - Services Protocol
protocol ServicesProtocol {
    // Movie Functions
    func fetchUpComingMovies(page: Int, onSuccess: @escaping (UpComingMovieModel?) -> Void, onError: @escaping (AFError) -> Void)
    func fetchNowPlayingMovies(page: Int, onSuccess: @escaping (NowPlayingMovieModel?) -> Void, onError: @escaping (AFError) -> Void)
    func getMovieDetail(movieID: Int, onSuccess: @escaping (MovieDetailModel?) -> Void, onError: @escaping (AFError) -> Void)

}

//MARK: - Services
final class Services: ServicesProtocol {
    func fetchUpComingMovies(page: Int, onSuccess: @escaping (UpComingMovieModel?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Constant.NetworkConstant.MovieServiceEndPoint.fetchUpComingMovies() + "&page=\(page)") { (response: UpComingMovieModel) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }

    }
    
    func fetchNowPlayingMovies(page: Int, onSuccess: @escaping (NowPlayingMovieModel?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Constant.NetworkConstant.MovieServiceEndPoint.fetchNowPlayingMovies()  + "&page=\(page)") { (response:NowPlayingMovieModel) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }

    }
    
    func getMovieDetail(movieID: Int, onSuccess: @escaping (MovieDetailModel?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Constant.NetworkConstant.MovieServiceEndPoint.fetchMovieDetail(movieID: movieID)) { (response: MovieDetailModel) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }

    }
    

}
