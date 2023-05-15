//
//  File.swift
//  DeezerApp
//
//  Created by Erkan on 10.05.2023.
//

import Foundation
import UIKit







protocol AritsViewModelDelegate: AnyObject {
    func didLoadInitialArtist()
    
    func didSelectArtist(artist: SingleArtist)
        
}


final class ArtistsListViewModel: NSObject{
    
    
    weak var delegate: AritsViewModelDelegate?
    
    var allArtists: [SingleArtist] = []{
        
        didSet{
            for artist in allArtists{
                guard let imageURL = URL(string: artist.pictureBig) else{
                    return
                }
            
                let viewModel = ArtistCollectionViewCellViewModel(artistName: artist.name, artistImage: imageURL, artistID: artist.id)
                cellViewModels.append(viewModel)
               
                
            }

        }
        
    }
    
 

    
    private var cellViewModels: [ArtistCollectionViewCellViewModel] = []
    
    
    
    func fetchArtists(genreID: Int){
        
    
        APICaller.shared.fetchArtists(genreID: genreID) { [weak self] result in
      
            switch result{
            case .success(let artists):
         
                self?.allArtists = artists.data
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialArtist()
                }
               
               

            case .failure(let error):
                print(error)
            }
        }
        
        
        
    }
    
    

    
    

    
    
    
    
    
}


extension ArtistsListViewModel: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistCollectionViewCell.identifier, for: indexPath) as? ArtistCollectionViewCell else{
            fatalError("Unsupported cell")
        }
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(viewModel: viewModel)
       // cell.backgroundColor = .purple
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        
        
        return CGSize(width: (bounds.width - 30) / 2, height: bounds.height / 4)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = allArtists[indexPath.row]

        delegate?.didSelectArtist(artist: selectedItem)
    }
    
    
    
}
