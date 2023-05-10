//
//  SingleCollectionCellViewModel.swift
//  DeezerApp
//
//  Created by Erkan on 11.05.2023.
//

import Foundation


import Foundation
import Alamofire



final class SingleCollectionCellViewModel{
    
    let albumName: String
    let albumImage: URL?
    let albumID: Int
    
    
    
    
    init(albumName: String, albumImage: URL, albumID: Int){
        self.albumName = albumName
        self.albumImage = albumImage
        self.albumID = albumID
        
    }
    
    func fetchImage(completion: @escaping(Result<Data,Error>) -> Void){
        
        guard let imageURL = albumImage else{return}
        
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
