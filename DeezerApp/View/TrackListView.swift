//
//  TrackListView.swift
//  DeezerApp
//
//  Created by Erkan on 11.05.2023.
//

import Foundation
import UIKit
import RealmSwift


protocol TrackListViewDelegate: AnyObject{
    
    func listViewTrack(trackView: TrackListView, track: TrackData)
}


let realm = try! Realm()



final class TrackListView: UIView{
    
    private let viewModel = TrackListViewModel()
    public weak var delegate: TrackListViewDelegate?
    
    var byTrackID: Int = 0{
        didSet{
         
            
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
        
        let objects = realm.objects(ObjectTrack.self)

        /*for object in objects {
            print(object.trackID)
            // veya print(object) şeklinde tüm objeyi yazdırabilirsiniz.
        }
        */
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
        print("Yenilendi ama yeni")
    }
    
    
    
    /*func didSelectArtist(artist: SingleArtist) {
        delegate?.listViewArtists(artistView: self, artist: artist)
    }*/
    
    
    
    
    
    
}
