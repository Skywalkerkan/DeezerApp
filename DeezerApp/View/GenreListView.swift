//
//  GenreListView.swift
//  DeezerApp
//
//  Created by Erkan on 9.05.2023.
//

import Foundation
import UIKit

protocol GenreListViewDelegate: AnyObject{
    
    func listViewGenre(genreView: GenreListView, genre: Genre)
}

final class GenreListView: UIView{
    
    
    public weak var delegate: GenreListViewDelegate?
    
    private let viewModel = GenreViewModel()
    
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.color = .cyan
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    
    
    private let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        let collecitonView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collecitonView.translatesAutoresizingMaskIntoConstraints = false
        collecitonView.isHidden = true
        collecitonView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        return collecitonView
    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
     //   backgroundColor = .green
        addSubviews(views: collectionView, spinner)
        
        addConstraints()
        spinner.startAnimating()
        
        viewModel.fetchGenres()
        viewModel.delegate = self
        
        collectionViewSetup()
       // collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func addConstraints(){
        
        // Spinner
        spinner.widthAnchor.constraint(equalToConstant: 120).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 120).isActive = true
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        
        
        //CollectionView
        collectionView.anchor(top: safeAreaLayoutGuide.topAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    
    private func collectionViewSetup(){
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        
        
        
 
    }
    
    
    
    
    
    
}


extension GenreListView: GenreViewModelDelegate{
    func didSelectGenre(genre: Genre) {
        delegate?.listViewGenre(genreView: self, genre: genre)
    }
    
    func didLoadInitialGenre() {
        collectionView.reloadData()
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.collectionView.isHidden = false
            
            UIView.animate(withDuration: 0.4) {
                self.collectionView.alpha = 1
            }
            
            
        }
    }
    
    
}
