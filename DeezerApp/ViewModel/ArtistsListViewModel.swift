//
//  File.swift
//  DeezerApp
//
//  Created by Erkan on 10.05.2023.
//

import Foundation
import UIKit




/*protocol ArtistViewModelDelegate: AnyObject{
    
    func didSelectGenre(genre: Int)
    
}*/


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
              //  print(imageURL)
                let viewModel = ArtistCollectionViewCellViewModel(artistName: artist.name, artistImage: imageURL, artistID: artist.id)
                cellViewModels.append(viewModel)
               
                
            }

        }
        
    }
    
  /*  var genrecik: Int = 0
    
    
    var genreID: Int = 0{
        didSet{
            
         //  print(genreID)
           
            
            
            
            //self.delegate?.didLoadInitialArtist()
            
            
          
            
            
        }
    }*/

    
    private var cellViewModels: [ArtistCollectionViewCellViewModel] = []
    
    
    
    func fetchArtists(genreID: Int){
        
       // print(self.genreID)
        APICaller.shared.fetchArtists(genreID: genreID) { [weak self] result in
          //  print(self.genreID)
            switch result{
            case .success(let artists):
                //print(artists)
                print(artists.data.first?.name)
                self?.allArtists = artists.data
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialArtist()
                }
               
               

            //    print(self.allArtists)
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
        print(selectedItem.name)
        delegate?.didSelectArtist(artist: selectedItem)
    }
    
    
    
}
