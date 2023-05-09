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
    let type: String
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



/*"id": "27",
"name": "Daft Punk",
"link": "https://www.deezer.com/artist/27",
"share": "https://www.deezer.com/artist/27?utm_source=deezer&utm_content=artist-27&utm_term=0_1683640478&utm_medium=web",
"picture": "https://api.deezer.com/artist/27/image",
"picture_small": "https://e-cdns-images.dzcdn.net/images/artist/f2bc007e9133c946ac3c3907ddc5d2ea/56x56-000000-80-0-0.jpg",
"picture_medium": "https://e-cdns-images.dzcdn.net/images/artist/f2bc007e9133c946ac3c3907ddc5d2ea/250x250-000000-80-0-0.jpg",
"picture_big": "https://e-cdns-images.dzcdn.net/images/artist/f2bc007e9133c946ac3c3907ddc5d2ea/500x500-000000-80-0-0.jpg",
"picture_xl": "https://e-cdns-images.dzcdn.net/images/artist/f2bc007e9133c946ac3c3907ddc5d2ea/1000x1000-000000-80-0-0.jpg",
"nb_album": 35,
"nb_fan": 4434094,
"radio": true,
"tracklist": "https://api.deezer.com/artist/27/top?limit=50",
"type": "artist"*/
