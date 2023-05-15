//
//  GenreModel.swift
//  DeezerApp
//
//  Created by Erkan on 9.05.2023.
//

import Foundation


struct Genres: Codable{
    
    let data: [Genre]
    
}


struct Genre: Codable{
    let id: Int
    let name: String
    let picture: String
    let picture_small: String
    let picture_medium: String
    let picture_big: String
    let picture_xl: String
    let type: String?
}



