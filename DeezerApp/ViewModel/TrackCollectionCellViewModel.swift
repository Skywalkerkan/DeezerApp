//
//  TrackCollectionCellViewModel.swift
//  DeezerApp
//
//  Created by Erkan on 11.05.2023.
//

import Foundation
import Alamofire


final class TrackCollectionCellViewModel{
    
    
    let trackName: String
    let trackImage: URL?
    let trackID: Int
    let trackDuration: Int
    
    
    init(trackName: String, trackImage: URL, trackID: Int, trackDuration: Int){
        self.trackName = trackName
        self.trackImage = trackImage
        self.trackID = trackID
        self.trackDuration = trackDuration
        
    }
    
    func fetchImage(completion: @escaping(Result<Data,Error>) -> Void){
        
        guard let imageURL = trackImage else{return}
        
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
