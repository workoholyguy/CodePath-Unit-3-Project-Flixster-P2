//
//  Movie.swift
//  project2-flixster-pt11
//
//  Created by Omar Madjitov on 3/8/23.
//

import Foundation

struct Movie: Decodable {
    let backdrop_path: URL
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: URL
    let vote_average: Double
    let vote_count: Int
    let baseUrlString = "https://image.tmdb.org/t/p/original"
    
}

struct MoviesResponse: Decodable {
    
    var results: [Movie]
    
}

extension Movie {

    // We can now access this array of mock tracks anywhere like this:
    // let tracks = Tracks.mockTracks
}
