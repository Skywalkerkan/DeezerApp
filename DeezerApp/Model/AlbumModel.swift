//
//  AlbumModel.swift
//  DeezerApp
//
//  Created by Erkan on 10.05.2023.
//

import Foundation


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Albums: Codable {
    let data: [Album]
    let total: Int
    let next: String?
}

// MARK: - Datum
struct Album: Codable {
    let id: Int
    let title: String
    let link, cover: String
    let coverSmall, coverMedium, coverBig, coverXl: String
    let md5Image: String
    let genreID, fans: Int
    let releaseDate: String
    let recordType: RecordTypeEnum
    let tracklist: String
    let explicitLyrics: Bool
    let type: RecordTypeEnum

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
        case recordType = "record_type"
        case tracklist
        case explicitLyrics = "explicit_lyrics"
        case type
    }
}

enum RecordTypeEnum: String, Codable {
    case album = "album"
    case ep = "ep"
    case single = "single"
}
