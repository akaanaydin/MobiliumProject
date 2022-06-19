//
//  UpComingMovie.swift
//  MobiliumProject
//
//  Created by Arslan Kaan AYDIN on 19.06.2022.
//

import Foundation

// MARK: - UpComingMovieModel
struct UpComingMovieModel: Codable {
    let results: [UpComingMovieModelResult]?

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - UpComingMovieModelResult
struct UpComingMovieModelResult: Codable {
    let id: Int?
    let title: String?
    let overview: String?
    let posterPath, releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case title = "title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
