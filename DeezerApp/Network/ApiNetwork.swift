//
//  ApiNetwork.swift
//  DeezerApp
//
//  Created by Erkan on 9.05.2023.
//

import Foundation
import Alamofire

class APICaller{
    
    static let shared = APICaller()
    
    let urlGenre = "https://api.deezer.com/genre"
    
    let baseURL = "https://api.deezer.com"
    
//https://api.deezer.com/genre/152/artists
    
    func fetchGenres(urlString: String = APICaller.shared.baseURL, completion: @escaping (Result<Genres, NetworkError>) -> Void){
        
        let urlString = urlString + UrlPath.genre.rawValue
        
        guard let url = URL(string: urlString) else{
            completion(.failure(.invalidUrl))
            return
        }
        
        AF.request(url)
          .validate()
          .responseDecodable(of: Genres.self) { response in
            // 4
              switch response.result{
              case .success(let data):
                  completion(.success(data))
              case .failure(let error):
                  print(error)
                  completion(.failure(.invalidResponse))
              }
        }
        
        
    }
    
    
    
    func fetchArtists(genreID: Int, completion: @escaping (Result<Artists, NetworkError>) -> Void){

        let urlString = baseURL + UrlPath.genre.rawValue + "/\(genreID)" + "/artists"
        
    
        guard let url = URL(string: urlString) else{
            completion(.failure(.invalidUrl))
            return
        }
        
        AF.request(url)
          .validate()
          .responseDecodable(of: Artists.self) { response in
            // 4
              switch response.result{
              case .success(let data):
                  completion(.success(data))
              case .failure(let error):
                  print(error)
                  completion(.failure(.invalidResponse))
              }
        }
        
        
    }
    
    //https://api.deezer.com/artist/27
    
    func fetchSingleArtist(artistID: Int, completion: @escaping (Result<SingleArtist, NetworkError>) -> Void){
        
        let urlString = baseURL + UrlPath.artist.rawValue + "\(artistID)"
        
        
        guard let url = URL(string: urlString) else{
            completion(.failure(.invalidUrl))
            return
            
        }
        
        print(url)
        AF.request(url).validate().responseDecodable(of: SingleArtist.self){ response in
            
            switch response.result{
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error)
                completion(.failure(NetworkError.invalidResponse))
            }
            
        }
        
        
        
    }
    
    
    func fetchAlbums(artistID: Int, completion: @escaping (Result<Albums, NetworkError>) -> Void){
        
        let urlString = baseURL + UrlPath.artist.rawValue + "\(artistID)" + UrlPath.albums.rawValue
        
        
        guard let url = URL(string: urlString) else{
            completion(.failure(.invalidUrl))
            return
            
        }
        
        print(url)
        AF.request(url).validate().responseDecodable(of: Albums.self){ response in
            
            switch response.result{
            case .success(let data):
                completion(.success(data))
                
            case .failure(let error):
                print(error)
                completion(.failure(NetworkError.invalidResponse))
            }
            
        }
        
        
    }
    
    func fetchTracks(albumID: Int, completion: @escaping (Result<Tracks, NetworkError>) -> Void){
        
        let urlString = baseURL + UrlPath.album.rawValue + "/\(albumID)" + UrlPath.tracks.rawValue
        
        
        guard let url = URL(string: urlString) else{
            completion(.failure(.invalidUrl))
            return
            
        }
        
        print(url)
        AF.request(url).validate().responseDecodable(of: Tracks.self){ response in
            
            switch response.result{
            case .success(let data):
                completion(.success(data))
                
            case .failure(let error):
                print(error)
                completion(.failure(NetworkError.invalidResponse))
            }
            
        }
        
        
    }
    
    
    func fetchSingleTrack(trackID: [Int], completion: @escaping (Result<TrackData, NetworkError>) -> Void){
        
        trackID.forEach { trackID in
            
            let urlString = baseURL + UrlPath.track.rawValue + "/\(trackID)"
            
            
            guard let url = URL(string: urlString) else{
                completion(.failure(.invalidUrl))
                return
                
            }
            
            print(url)
            AF.request(url).validate().responseDecodable(of: TrackData.self){ response in
                
                switch response.result{
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(let error):
                    print(error)
                    completion(.failure(NetworkError.invalidResponse))
                }
                
            }
        }
   
        
        
    }
    
    
    
    
    
    

    
    
    
    
    
    
    
    
}
