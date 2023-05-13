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
    
    var trackIDs = [Int]()

    var isFilled = true
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
               
                
        
        
        
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    var tracksCopy: [TrackData]?
    
    
    
    override func viewWillAppear(_ animated: Bool) {
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
            print(trackIDs)
        
                
        APICaller.shared.fetchSingleTrack(trackID: trackIDs) { result in
            switch result{
            case .success(let data):
                
                print(data)
                self.begeniler.append(data)
                print(data.title)
            case .failure(let error):
                print(error)
            }
            if self.begeniler.count == self.trackIDs.count{
                print("son")
                print(self.begeniler.count)
             //   let trackDataArray = Array(self.begeniler)
               self.begeniler.sort { $0.title > $1.title }
              
              // let sortedTrackData = begeniler.sorted { $0.count < $1.count }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                
                    self.collectionView.reloadData()
                }
            }
           
        }
       // print(begeniler)
    }
    
    
    func collectionViewReload(Int: Int, begeniler: [TrackData]){
        
      //  self.begeniler.removeAll()
      //  self.trackIDs.removeAll()
        print(Int)
        print(begeniler.count)
        self.begeniler = begeniler
       // print(begeniler[Int].title)
        self.begeniler.remove(at: Int)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        
        }
        for track in self.begeniler{
            print(track.title)
        }
        print("skfdsfasdf")
       /* do {
                    let realm = try Realm()
                    let results = realm.objects(ObjectTrack.self)
                    for track in results {
                        trackIDs.append(track.trackID)
                        print("****")
                        
                    }
                } catch let error {
                    print("Error retrieving track IDs: \(error.localizedDescription)")
                }
        
        print(trackIDs)
        APICaller.shared.fetchSingleTrack(trackID: trackIDs) { result in
            switch result{
            case .success(let data):
               // print(data.title)
                self.begeniler.append(data)
            case .failure(let error):
                print(error)
            }
            if self.begeniler.count == self.trackIDs.count{
                print(self.begeniler.count)
                for track in self.begeniler{
                    print(track.title)
                }
                DispatchQueue.main.async {
                    print("yenileniyor")

                    self.collectionView.reloadData()
                   

                }
                
            }
           
        }*/
        print(begeniler.count)
        print("yenile")
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
       /* let heartButton = UIButton()
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        
        heartButton.tintColor = .systemPink
        
        self.imageHeart = UIImageView(image: UIImage(systemName: "heart.fill"))
        heartButton.setBackgroundImage(imageHeart.image?.withTintColor(.systemPink, renderingMode: .alwaysOriginal), for: .normal)
        heartButton.addTarget(self, action: #selector(begenClicked), for: .touchUpInside)
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .green
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Evet"
 
       // heartButton.addTarget(self, action: #selector(<#T##@objc method#>), for: <#T##UIControl.Event#>)
        cell.addSubview(heartButton)
        cell.addSubview(imageView)
        cell.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            heartButton.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -10),
            heartButton.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            heartButton.widthAnchor.constraint(equalToConstant: 40),
            heartButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        imageView.anchor(top: cell.topAnchor, bottom: cell.bottomAnchor, leading: cell.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 100, height: 0)
        nameLabel.anchor(top: cell.topAnchor, bottom: nil, leading: imageView.trailingAnchor, trailing: heartButton.leadingAnchor, paddingTop: 30, paddingBottom: 0, paddingLeft: 20, paddingRight: 0, width: 0, height: 30)
        nameLabel.text = begeniler[indexPath.row].title
        */
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let previewURL = URL(string: begeniler[indexPath.row].preview) else{
            return
        }
        let playerItem:AVPlayerItem = AVPlayerItem(url: previewURL)
        self.player = AVPlayer(playerItem: playerItem)
        if player?.rate == 0
                {
                    player!.play()
            print("Çalıyor")
                    //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
                } else {
                    player!.pause()
                    print("Çalmıyor")
                    //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
                }
    }
    
    
    @objc func begenClicked(){
        
        print("begeni basidli")
        
            isFilled.toggle()
        
        /*let image = isFilled ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
         tintColor = isFilled ? .systemPink : .systemGray*/
           // print(begeniler[indexpath])
        
        
        
        
        
        if isFilled {
            // self.imageHeart.image = UIImage(systemName: "heart.fill")!
            
            print("ekle")
            
            /*  let newObject = ObjectTrack()
             newObject.trackID = trackID
             
             try! realm.write {
             realm.add(newObject)
             }
             print("Basılı")
             DispatchQueue.main.async {
             self.delegatecik?.didLoadInitialTracks()
             }
             
             tintColor = .systemPink*/
            //collectionView.reloadData()
        } else {
            /*image = UIImage(systemName: "heart")!
             
             guard let trackID = trackID else {
             return
             }
             
             let objectsToDelete = realm.objects(ObjectTrack.self).filter("trackID == %@", trackID)
             
             try! realm.write {
             realm.delete(objectsToDelete)
             }
             DispatchQueue.main.async {
             self.delegatecik?.didLoadTracks()
             }
             */
            
            print("Sil")
            
            //  tintColor = .systemGray
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        
        return CGSize(width: bounds.width - 20, height: 100)
        
    }

}

