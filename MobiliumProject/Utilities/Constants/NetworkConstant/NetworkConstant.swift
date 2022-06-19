//
//  NetworkConstant.swift
//  MobiliumProject
//
//  Created by Arslan Kaan AYDIN on 19.06.2022.
//

import Foundation

extension Constant {
// MARK: - Network Constant
    class NetworkConstant{
        
        enum MovieServiceEndPoint: String {
            
        case BASE_URL = "https://api.themoviedb.org"
        case API_KEY = "1999312a18328994486d17f7744c8af2"
        case IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w1280"
            
            static func fetchUpComingMovies() -> String {
                "\(BASE_URL.rawValue)/3/movie/upcoming?api_key=\(API_KEY.rawValue)"
            }
            
            static func fetchNowPlayingMovies() -> String {
                "\(BASE_URL.rawValue)/3/movie/now_playing?api_key=\(API_KEY.rawValue)"
            }
            
            static func fetchMovieDetail(movieID: Int) -> String {
                "\(BASE_URL.rawValue)/3/movie/\(movieID)?api_key=\(API_KEY.rawValue)"
            }
            
        }
    }
}

//MOVIE
//https://api.themoviedb.org/3/movie/upcoming?api_key=1999312a18328994486d17f7744c8af2
//https://api.themoviedb.org/3/movie/now_playing?api_key=1999312a18328994486d17f7744c8af2
