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
    
 //   func didSelectArtist(artist: Album)
        
}



final class SingleArtistViewModel: NSObject{
    
    
    weak var delegate: AlbumViewModelDelegate?
    
    var albums: [Album] = []{
        
        didSet{
            for album in albums{
                guard let imageURL = URL(string: album.coverMedium) else{
                    return
                }
              //  print(imageURL)
                let viewModel = SingleCollectionCellViewModel(albumName: album.title, albumImage: imageURL, albumID: album.id)
                cellViewModels.append(viewModel)
               
                
            }
        }
        
        
    }
    
    
    private var cellViewModels: [SingleCollectionCellViewModel] = []
    
    func fetchSingleArtist(artistID: Int){
        
        APICaller.shared.fetchSingleArtist(artistID: artistID) { [weak self] result in
            switch result{
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
                
            }
        }
        
        APICaller.shared.fetchAlbums(artistID: artistID) { [weak self] result in
            switch result{
            case .success(let data):
               // print(data)
                print("albumler")
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
    
    
    
    
    
    /*func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .brown
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = "Notification Times"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .yellow

        
      //  tableView.sectionHeaderTopPadding = 0

        headerView.addSubview(label)
        
        return headerView
            
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }*/
    
    
    
}
