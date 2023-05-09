//
//  GenreCollectionViewCellViewModel.swift
//  DeezerApp
//
//  Created by Erkan on 9.05.2023.
//

import Foundation
import Alamofire
import UIKit



final class GenreCollectionViewCellViewModel{
    
    
    public let genreName: String
    private let genreImageURL: URL?
    
    init(genreName: String, genreImageURL: URL?){
        
        self.genreName = genreName
        self.genreImageURL = genreImageURL
        
        
        
    }
    
    
    func fetchImage(completion: @escaping(Result<Data, Error>) -> Void){
        guard let url = genreImageURL else{
            return
        }
        
        AF.request(url).responseData { response in
            switch response.result{
            case .success(let imageData):
                completion(.success(imageData))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
        
    }
    
    
    
}
