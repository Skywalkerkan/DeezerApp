//
//  BegenilerListView.swift
//  DeezerApp
//
//  Created by Erkan on 11.05.2023.
//

import Foundation
import UIKit
import RealmSwift


protocol BegeniListViewDelegate: AnyObject{
    
    func listViewTrack(trackView: BegeniListView, track: TrackData)
}



final class BegeniListView: UIView{
    
    private let viewModel = BegeniListViewModel()
    public weak var delegate: BegeniListViewDelegate?
    

    
    
    
    private let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TrackCollectionViewCell.self, forCellWithReuseIdentifier: TrackCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    var trackIDS: [Int] = []{
        
        didSet{
            DispatchQueue.main.async {
                self.viewModel.fetchSingleTrack(trackID: self.trackIDS)
                print("sonu")
            }
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.backgroundColor = .red
        print("Napıyon")
        let objects = realm.objects(ObjectTrack.self)

        for object in objects {
           // print(object.trackID)
            trackIDS.append(object.trackID)


            guard let lastObject = objects.last else{
                return
            }
          //  print(lastObject.trackID)
          //  print(object.trackID)
            if lastObject.trackID == object.trackID{
                print("gihopppaarildi")
                print(trackIDS)
                
                self.viewModel.fetchSingleTrack(trackID: self.trackIDS)
            }
          //  print("devamke")
            // veya print(object) şeklinde tüm objeyi yazdırabilirsiniz.
        }
        
        
        translatesAutoresizingMaskIntoConstraints = false


        
        viewModel.delegate = self
        addSubview(collectionView)
        backgroundColor = .cyan
        
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


extension BegeniListView: BegeniListViewModelDelegate{
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
