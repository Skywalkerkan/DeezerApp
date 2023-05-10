//
//  ArtistCollectionViewCellViewModel.swift
//  DeezerApp
//
//  Created by Erkan on 10.05.2023.
//

import Foundation
import Alamofire



final class ArtistCollectionViewCellViewModel{
    
    let artistName: String
    let artistImage: URL?
    let artistID: Int
    
    
    
    
    init(artistName: String, artistImage: URL, artistID: Int){
        self.artistName = artistName
        self.artistID = artistID
        self.artistImage = artistImage
        
    }
    
    func fetchImage(completion: @escaping(Result<Data,Error>) -> Void){
        
        guard let imageURL = artistImage else{return}
        
        AF.request(imageURL).responseData { response in
            switch response.result{
            case .success(let imageData):
                completion(.success(imageData))
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
        
        
        
    }
    
    
    
    
    
    
}
