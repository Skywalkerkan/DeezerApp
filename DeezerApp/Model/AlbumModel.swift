//
//  AlbumModel.swift
//  DeezerApp
//
//  Created by Erkan on 10.05.2023.
//

import Foundation



import Foundation


struct Albums: Codable {
    let data: [Album]
    let total: Int
    let next: String?
}


struct Album: Codable {
    let id: Int
    let title: String
    let link, cover: String
    let coverSmall, coverMedium, coverBig, coverXl: String
    let md5Image: String
    let genreID, fans: Int
    let releaseDate: String
    let tracklist: String
    let explicitLyrics: Bool
   

    enum CodingKeys: String, CodingKey {
        case id, title, link, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case md5Image = "md5_image"
        case genreID = "genre_id"
        case fans
        case releaseDate = "release_date"
        case tracklist
        case explicitLyrics = "explicit_lyrics"
    }
}


