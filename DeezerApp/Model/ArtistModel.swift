//
//  ArtistModel.swift
//  DeezerApp
//
//  Created by Erkan on 9.05.2023.
//

import Foundation



struct Artists: Codable {
    let data: [SingleArtist]
}


struct SingleArtist: Codable{
    let id: Int
    let name: String
    let picture: String
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String
    let radio: Bool
    let tracklist: String
    let type: String?
    let nb_album: Int?
    let nb_fan: Int?
    let link: String?
    let share: String?

    enum CodingKeys: String, CodingKey {
        case id, name, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case radio, tracklist, type, nb_album, nb_fan,share,link
    }
}



