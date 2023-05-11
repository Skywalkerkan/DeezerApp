//
//  TrackModel.swift
//  DeezerApp
//
//  Created by Erkan on 11.05.2023.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//


// MARK: - Welcome
struct Tracks: Codable {
    let data: [TrackData]
    let total: Int
}

// MARK: - Datum
struct TrackData: Codable {
    let id: Int
    let readable: Bool
    let title, titleShort, isrc: String
    let titleVersion: String?
    let link: String
    let duration, trackPosition, diskNumber, rank: Int
    let explicitLyrics: Bool
    let explicitContentLyrics, explicitContentCover: Int
    let preview: String
    let md5Image: String?
    let artist: Artist?
    let type: DatumType

    enum CodingKeys: String, CodingKey {
        case id, readable, title
        case titleShort = "title_short"
        case titleVersion = "title_version"
        case isrc, link, duration
        case trackPosition = "track_position"
        case diskNumber = "disk_number"
        case rank
        case explicitLyrics = "explicit_lyrics"
        case explicitContentLyrics = "explicit_content_lyrics"
        case explicitContentCover = "explicit_content_cover"
        case preview
        case md5Image = "md5_image"
        case artist, type
    }
}

// MARK: - Artist
struct Artist: Codable {
    let id: Int
    let name: String
    let tracklist: String
    let type: String
}




enum DatumType: String, Codable {
    case track = "track"
}
