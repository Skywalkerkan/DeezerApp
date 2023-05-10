//
//  ArtistsListView.swift
//  DeezerApp
//
//  Created by Erkan on 10.05.2023.
//

import Foundation
import UIKit



protocol ArtistsListViewDelegate: AnyObject{
    
    func listViewArtists(artistView: ArtistsListView, artist: SingleArtist)
}

final class ArtistsListView: UIView{

    private let viewModel = ArtistsListViewModel()
    public weak var delegate: ArtistsListViewDelegate?
    
    var byIDArtist: Int = 0{
        didSet{
            print(byIDArtist)
            print("Yukardaki")
            viewModel.fetchArtists(genreID: byIDArtist)
        }
    }
    
    private let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ArtistCollectionViewCell.self, forCellWithReuseIdentifier: ArtistCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        viewModel.delegate = self
        addSubview(collectionView)
        addConstraints()
       
        collectionViewSetup()
        
        //print(viewModel.genrecik)
     //   print("listView\(viewModel.genrecik)")
       // viewModel.fetchArtists()
       
        
        
        
        
        
    }
    
    
    private func addConstraints() {
        collectionView.anchor(top: safeAreaLayoutGuide.topAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    
    private func collectionViewSetup(){
        
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


extension ArtistsListView: AritsViewModelDelegate{
    func didSelectArtist(artist: SingleArtist) {
        delegate?.listViewArtists(artistView: self, artist: artist)
    }
    
    func didLoadInitialArtist() {
        collectionView.reloadData()
    }
    
    
    
    
    
}
