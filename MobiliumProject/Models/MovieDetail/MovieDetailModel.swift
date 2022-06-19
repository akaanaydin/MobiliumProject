//
//  MovieDetail.swift
//  MobiliumProject
//
//  Created by Arslan Kaan AYDIN on 19.06.2022.
//

import Foundation

// MARK: - MovieDetailModel
struct MovieDetailModel: Codable {
    let imdbID, title, overview: String?
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case imdbID = "imdb_id"
        case title = "title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
