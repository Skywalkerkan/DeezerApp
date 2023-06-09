//
//  SingleArtistViewModel.swift
//  DeezerApp
//
//  Created by Erkan on 10.05.2023.
//

import Foundation
import UIKit



protocol AlbumViewModelDelegate: AnyObject {
    func didLoadInitialArtist()
    
    func didSelectAlbum(album: Album)
        
}



final class SingleArtistViewModel: NSObject{
    
    
    weak var delegate: AlbumViewModelDelegate?
    
    var albums: [Album] = []{
        
        didSet{
            for album in albums{
                guard let imageURL = URL(string: album.coverBig) else{
                    return
                }
                
              
                
             
                let viewModel = SingleCollectionCellViewModel(albumName: album.title, albumImage: imageURL, albumID: album.id, releaseDate: album.releaseDate)
                cellViewModels.append(viewModel)
               
                
            }
        }
        
        
    }
    
    
    private var cellViewModels: [SingleCollectionCellViewModel] = []
    var imageURL = ""
    
    func fetchSingleArtist(artistID: Int){
        
        APICaller.shared.fetchSingleArtist(artistID: artistID) { [weak self] result in
            switch result{
            case .success(let data):
              
              
                self?.imageURL = data.pictureBig
                
             
            case .failure(let error):
                print(error)
                
            }
        }
        
        APICaller.shared.fetchAlbums(artistID: artistID) { [weak self] result in
            switch result{
            case .success(let data):
               
                self?.albums = data.data
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialArtist()
                }
               

            case .failure(let error):
                print(error)
            }

        }
        
        
        
        
    }
    
    
    
    
    
}


extension SingleArtistViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SingleArtistCollectionViewCell.identifier, for: indexPath) as? SingleArtistCollectionViewCell else{
            fatalError("Unsupported cell")
        }
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(viewModel: viewModel)
       // cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        
        return CGSize(width: bounds.width - 20, height: 85)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: -0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = self.albums[indexPath.row]
        delegate?.didSelectAlbum(album: selectedItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as? MyHeaderFooterClass else{
           fatalError("Unsupported")
        }
       // header.backgroundColor = .blue
        header.fetchImage(imageURL: imageURL)
         return header
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 230)
    }

    
    
    
    
    
    
    
    
    
}
