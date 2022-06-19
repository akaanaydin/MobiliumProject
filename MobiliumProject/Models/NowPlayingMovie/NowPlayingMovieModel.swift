//
//  NowPlayingMovie.swift
//  MobiliumProject
//
//  Created by Arslan Kaan AYDIN on 19.06.2022.
//

import Foundation

// MARK: - NowPlayingMovieModel
struct NowPlayingMovieModel: Codable {
    let results: [NowPlayingMovieModelResult]?

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - NowPlayingMovieModelResult
struct NowPlayingMovieModelResult: Codable {
    let id: Int?
    let title: String?
    let overview: String?
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case title = "title"
        case posterPath = "poster_path"
    }
}
