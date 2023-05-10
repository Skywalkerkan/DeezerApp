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
    public let genreID: Int
    
    init(genreName: String, genreImageURL: URL?, genreID: Int){
        
        self.genreName = genreName
        self.genreImageURL = genreImageURL
        self.genreID = genreID
        
        
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
