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



final class BegeniListView: UIView, BegeniListViewModelDelegate{
    
    private let viewModel = BegeniListViewModel()
    public weak var delegate: BegeniListViewDelegate?
    

    
    
    
    private let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TrackCollectionViewCell.self, forCellWithReuseIdentifier: TrackCollectionViewCell.identifier)
        return collectionView
    }()
    
    var collectionReload = 0{
        didSet{
            DispatchQueue.main.async {
                print("Yenilendi")
                self.collectionView.reloadData()
            }
            
        }
    }
    
    var trackIDS: [Int] = []{
        
        didSet{
            
            self.viewModel.fetchSingleTrack(trackID: self.trackIDS)
            DispatchQueue.main.async {
              //  print("AAAAAAA")
              //  print(self.trackIDS)
              //  print("sonu")
                self.collectionView.reloadData()
                //self.trackIDS.removeAll()
            }
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       // collectionView.backgroundColor = .red
        print("Saçma girdi")
        
        let objects = realm.objects(ObjectTrack.self)

        for object in objects {
           // print(object.trackID)
          //buuuu  trackIDS.append(object.trackID)


            guard let lastObject = objects.last else{
                return
            }
          //  print(lastObject.trackID)
          //  print(object.trackID)
            if lastObject.trackID == object.trackID{
              //  print("gihopppaarildi")
              //  print(trackIDS)
                
               //BUUUUU self.viewModel.fetchSingleTrack(trackID: self.trackIDS)
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


extension BegeniListView: BegeniListViewModelDelegate2{
    func didLoadTracks() {
        print("Load edildi")
        
        collectionView.reloadData()
    }
    
    func didSelectTrack(track: TrackData) {
        delegate?.listViewTrack(trackView: self, track: track)
    }
    
    
    func didLoadInitialTracks() {
        print("yenilendi collection")
        collectionView.reloadData()
    }
    
    
    
    /*func didSelectArtist(artist: SingleArtist) {
        delegate?.listViewArtists(artistView: self, artist: artist)
    }*/
    
    
    
    
    
    
}
