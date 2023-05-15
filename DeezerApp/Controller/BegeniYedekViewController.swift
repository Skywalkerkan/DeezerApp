//
//  BegeniYedekViewController.swift
//  DeezerApp
//
//  Created by Erkan on 12.05.2023.
//

import UIKit
import RealmSwift
import AVFoundation



class BegeniYedekViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let shared = BegeniYedekViewController()

    
    let realm = try! Realm()
    var trackIDs = [Int]()
    var notificationToken: NotificationToken?
    let cellId = "cellId"
    
    var begeniler: [TrackData] = []
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    

    
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationItem.title = "Beğeniler"
        collectionView.register(BegenilerCollectionViewCell.self, forCellWithReuseIdentifier: BegenilerCollectionViewCell.identifier)
        
    
        
        notificationToken = realm.observe { [weak self] _, _ in
                    self?.updateCollectionView()
                }
        
        
     
        
        updateFirstLoad()
    
       
        
        

        
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    func updateFirstLoad(){
        self.begeniler.removeAll()
        self.trackIDs.removeAll()
        
        do {
                    let realm = try Realm()
                    let results = realm.objects(ObjectTrack.self)
                    for track in results {
                        trackIDs.append(track.trackID)
                    }
                } catch let error {
                    print("Error retrieving track IDs: \(error.localizedDescription)")
                }
    
        
                
        APICaller.shared.fetchSingleTrack(trackID: trackIDs) { result in
            switch result{
            case .success(let data):
                
               
                self.begeniler.append(data)
           
            case .failure(let error):
                print(error)
            }
            if self.begeniler.count == self.trackIDs.count{
                print("son")
          
                self.begeniler.sort { $0.title ?? "MusicPlayer"  > $1.title ?? "Music"  }
              
           
                DispatchQueue.main.async {
                
                    self.collectionView.reloadData()
                   
                }
            }
           
        }
    }
    
    
    
    
    var tracksIDS: [Int] = []
    

    
    func updateCollectionView() {
        
        
        self.tracksIDS.removeAll()
        self.begeniler.removeAll()
        do {
            let realm = try Realm()
            let results = realm.objects(ObjectTrack.self)
            let data = Array(results)
            guard data.count > 0 else {
                self.begeniler.removeAll()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                return
            }
            
            for data in data{
               
                tracksIDS.append(data.trackID)
            }
           
           //
            APICaller.shared.fetchSingleTrack(trackID: tracksIDS) { result in
                switch result{
                case .success(let data):
                    
                    
                    self.begeniler.append(data)
                    
                case .failure(let error):
                    print(error)
                    self.collectionView.reloadData()
                }

                if self.begeniler.count == self.tracksIDS.count{
     
                    
                 //   let trackDataArray = Array(self.begeniler)
                    self.begeniler.sort { $0.id ?? 0 > $1.id ?? 0 }
                  
                
                    DispatchQueue.main.async {
                       // if self.pla
                        
                        if self.player?.timeControlStatus == .playing {
                            print("AVPlayer is currently playing.")
                            self.player!.pause()
                        }
                       
                        
                        
                        
                        self.collectionView.reloadData()
                    }
                }
               
            }
            self.collectionView.reloadData()
        } catch let error {
            print("Error retrieving data: \(error.localizedDescription)")
        }
    }
    
  
    
    
    
  
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return begeniler.count
    }
    
    var imageHeart = UIImageView()
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BegenilerCollectionViewCell.identifier, for: indexPath) as? BegenilerCollectionViewCell else{
            fatalError("Unsupported")
            
        }
        cell.backgroundColor = .secondarySystemBackground
        
        cell.configure(trackData: begeniler[indexPath.row], trackSira: indexPath.row, begeniler: begeniler)
       
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let previewBegeniler = begeniler[indexPath.row].preview else{
            return
        }
        
        guard let previewURL = URL(string: previewBegeniler) else{
            return
        }
        let playerItem:AVPlayerItem = AVPlayerItem(url: previewURL)
        self.player = AVPlayer(playerItem: playerItem)
        if player?.rate == 0
                {
                    player!.play()
            print("Çalıyor")
                  
                } else {
                    player!.pause()
                    print("Durdur")
                    
                }
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        
        return CGSize(width: bounds.width - 20, height: 100)
        
    }

}


