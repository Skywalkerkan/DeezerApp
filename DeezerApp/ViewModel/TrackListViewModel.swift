//
//  TrackListViewModel.swift
//  DeezerApp
//
//  Created by Erkan on 11.05.2023.
//

import Foundation
import UIKit



protocol TrackListViewModelDelegate: AnyObject {
    func didLoadInitialTracks()
    
    func didSelectTrack(track: TrackData)
  //  func didSelectAlbum(track: TrackData)
        
}


final class TrackListViewModel: NSObject{
    
    
    weak var delegate: TrackListViewModelDelegate?
    
    let imageURL = "https://e-cdns-images.dzcdn.net/images/cover/"

    var tracks: [TrackData] = [] {
        
  //  2e018122cb56986277102d2041a592c8/1000x1000-000000-80-0-0.jpg
        
        
        didSet{
            for track in tracks{
                guard let md5Image = track.md5Image else{
                    return
                }
                let url = imageURL + md5Image + "/500x500-000000-80-0-0.jpg"
                guard let imageURL = URL(string: url) else{
                    return
                }
                
                
                guard let trackID = track.id else{
                    return
                }
               
                
                let viewModel = TrackCollectionCellViewModel(trackName: track.title, trackImage: imageURL, trackID: trackID, trackDuration: track.duration)
               cellViewModel.append(viewModel)
                
               
                
            }
        }
    }
    
    
    private var cellViewModel: [TrackCollectionCellViewModel] = []
    
    
    
    
    func fetchAllTracks(albumID: Int){
        
        APICaller.shared.fetchTracks(albumID: albumID) { [weak self] result in
            switch result{
            case .success(let data):
               
                self?.tracks = data.data
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialTracks()

                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    
    
    
    
}


extension TrackListViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackCollectionViewCell.identifier, for: indexPath) as? TrackCollectionViewCell else{
            fatalError("Unsupported")
        }
        let viewModel = cellViewModel[indexPath.row]
        cell.configure(viewModel: viewModel)
       // cell.backgroundColor = .red
        cell.backgroundColor = .secondarySystemBackground
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        
        return CGSize(width: bounds.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = tracks[indexPath.row]
        delegate?.didSelectTrack(track: selectedItem)
    }
    
    
    
    
    
    
}
