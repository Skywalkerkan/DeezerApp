//
//  BegeniListViewModel.swift
//  DeezerApp
//
//  Created by Erkan on 11.05.2023.
//

import Foundation

import Foundation
import UIKit


protocol BegeniListViewModelDelegate: AnyObject {
    func didLoadInitialTracks()
    func didLoadTracks()
    
    func didSelectTrack(track: TrackData)
  //  func didSelectAlbum(track: TrackData)
        
}



final class BegeniListViewModel: NSObject{
    
    
    weak var delegate: BegeniListViewModelDelegate?
    
    let imageURL = "https://e-cdns-images.dzcdn.net/images/cover/"

    var tracks: [TrackData] = [] {
        
  //  2e018122cb56986277102d2041a592c8/1000x1000-000000-80-0-0.jpg
        
        
        didSet{
            print("girildiiiiiiiiiii")
            for track in tracks{
                print(track.title)
            }
            //cellViewModel.removeAll()
            
            for track in tracks{
              //  print(tracks.count)
                guard let md5Image = track.md5Image else{
                    return
                }
                let url = imageURL + md5Image + "/500x500-000000-80-0-0.jpg"
                guard let imageURL = URL(string: url) else{
                    return
                }
             //   print(imageURL)
                print(track.title)
                let viewModel = TrackCollectionCellViewModel(trackName: track.title, trackImage: imageURL, trackID: track.id, trackDuration: track.duration)
               cellViewModel.append(viewModel)
              //  print(cellViewModel.count)
               // print("Countsayısı")
             //   print(cellViewModel.count)
               
                
            }
        }
    }
    
    
    private var cellViewModel: [TrackCollectionCellViewModel] = []
    

    
    var sayi = 0
    var singleTrack: [TrackData] = []
    func fetchSingleTrack(trackID: [Int]){
        //self.tracks.removeAll()
      //  singleTrack.removeAll()
        self.tracks.removeAll()
        print("fetchsingle içi")
        //print(trackID)
        
        APICaller.shared.fetchSingleTrack(trackID: trackID) { [weak self] result in
            switch result{
            case .success(let data):
                self?.singleTrack.append(data)
               // print(data.preview)
                self?.sayi += 1
                if trackID.count == self?.sayi{
                    guard let singleTrack = self?.singleTrack else{
                        return
                    }
                   
                        self?.tracks = singleTrack
                    
                    print("****")
                    if let tracks = self?.tracks {
                        for track in tracks {
                            print(track.title)
                        }
                    }
                    print("boş")

                    print("****")
                    DispatchQueue.main.async {
                       // print("Data")
                        self?.delegate?.didLoadInitialTracks()
                        

                    }
                }
                //print(self?.tracks)

            case .failure(let error):
                print(error)
            }
     
        }
     //   print("son")
        
    }
    
    
    
    
    
    
}


extension BegeniListViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
