//
//  NetworkErrors.swift
//  DeezerApp
//
//  Created by Erkan on 9.05.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case requestFailed
    case invalidResponse
}
