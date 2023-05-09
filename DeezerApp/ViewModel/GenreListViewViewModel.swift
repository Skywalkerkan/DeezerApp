//
//  GenreListViewViewModel.swift
//  DeezerApp
//
//  Created by Erkan on 9.05.2023.
//

import Foundation
import UIKit




protocol GenreViewModelDelegate: AnyObject {
    func didLoadInitialValue()
        
}

final class GenreViewModel: NSObject{
    
    public weak var delegate : GenreViewModelDelegate?
    
    
    
    
    var allGenres: [Genre] = []{
    
        
        didSet{
            for genres in allGenres{
                guard let imageURL = URL(string: genres.picture) else{
                    return
                }
              //  print(imageURL)
                let viewModel = GenreCollectionViewCellViewModel(genreName: genres.name, genreImageURL: imageURL)
                cellViewModels.append(viewModel)
                
            }

        }
        
        
    }
    
    private var cellViewModels: [GenreCollectionViewCellViewModel] = []
    
    
    
    func fetchGenres(){
        APICaller.shared.fetchGenres { [weak self] result in
            switch result{
            case .success(let GenreData):
                    self?.allGenres = GenreData.data
                   // print(self?.allGenres)
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialValue()
                }
                
            case .failure(let error):
                print(error)
            }
        }

    }

}

extension GenreViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as? GenreCollectionViewCell else{
            fatalError("Wrong or Unsupported Cell")
        }
        let viewModel = cellViewModels[indexPath.row]
        cell.backgroundColor = .blue
        cell.configure(viewModel: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        let height = (bounds.height) / 4
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}
