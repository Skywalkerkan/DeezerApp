//
//  TrackListView.swift
//  DeezerApp
//
//  Created by Erkan on 11.05.2023.
//

import Foundation
import UIKit


protocol TrackListViewDelegate: AnyObject{
    
    func listViewTrack(trackView: TrackListView, track: TrackData)
}



final class TrackListView: UIView{
    
    private let viewModel = TrackListViewModel()
    public weak var delegate: TrackListViewDelegate?
    
    var byTrackID: Int = 0{
        didSet{
            print(byTrackID)
            
            viewModel.fetchAllTracks(albumID: byTrackID)
            
        }
    }
    
    
    
    private let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TrackCollectionViewCell.self, forCellWithReuseIdentifier: TrackCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        viewModel.delegate = self
        addSubview(collectionView)
        
        collectionView.anchor(top: safeAreaLayoutGuide.topAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        collectionViewSetup()
        
        
        
    }
    
    
    func collectionViewSetup(){
        
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
    }
    
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    
    
}


extension TrackListView: TrackListViewModelDelegate{
    func didSelectTrack(track: TrackData) {
        delegate?.listViewTrack(trackView: self, track: track)
    }
    
    
    func didLoadInitialTracks() {
        collectionView.reloadData()
    }
    
    
    
    /*func didSelectArtist(artist: SingleArtist) {
        delegate?.listViewArtists(artistView: self, artist: artist)
    }*/
    
    
    
    
    
    
}
