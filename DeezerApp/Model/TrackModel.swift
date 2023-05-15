//
//  TrackModel.swift
//  DeezerApp
//
//  Created by Erkan on 11.05.2023.
//

import Foundation


struct Tracks: Codable {
    let data: [TrackData]
    let total: Int
}


struct TrackData: Codable {
    let id: Int?
    let title: String?
    let titleShort, isrc: String?
    let titleVersion: String?
    let link: String?
    let duration, trackPosition, diskNumber, rank: Int?
    let explicitLyrics: Bool?
    let explicitContentLyrics, explicitContentCover: Int?
    let preview: String?
    let md5Image: String?
    let artist: Artist?
    

    enum CodingKeys: String, CodingKey {
        case id
        case title
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
        case artist
    }
}

// MARK: - Artist
struct Artist: Codable {
    let id: Int
    let name: String
    let tracklist: String
    let type: String
}





