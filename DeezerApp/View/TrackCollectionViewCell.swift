//
//  TrackCollectionViewCell.swift
//  DeezerApp
//
//  Created by Erkan on 11.05.2023.
//

import UIKit
import RealmSwift

protocol BegeniListViewModelDelegate2: AnyObject {
    func didLoadInitialTracks()
    func didLoadTracks()
    
    func didSelectTrack(track: TrackData)
  //  func didSelectAlbum(track: TrackData)
        
}



class TrackCollectionViewCell: UICollectionViewCell {
 
    
    
    var isFilled = false
    static let identifier = "TrackCollectionViewCell"
    
    private let viewModel = BegeniListViewModel()
    public weak var delegate: BegeniListViewModelDelegate?
    weak var delageteTrue: TrackListViewModelDelegate?
    weak var delegatecik: BegeniListViewModelDelegate2?
    
    
    var trackID: Int?
    
    private let trackImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray
        return imageView
    }()
    
    
    private let trackTime: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2.34"
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    private let trackName: UILabel = {
       let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Olacaklar sensiz olsun"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        return label
    }()
    
    
    
    private let heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let imageHeart = UIImageView(image: UIImage(systemName: "heart"))
        button.setBackgroundImage(imageHeart.image?.withTintColor(.systemGray, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(begenClicked), for: .touchUpInside)
        return button
    }()
    
    
    
    let realm = try! Realm()
    
    
    let myObject = ObjectTrack()
    var image = UIImage()
    
    @objc func begenClicked(){
        
        print("begeni basidli")
        
        isFilled.toggle()
        
        /*let image = isFilled ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        tintColor = isFilled ? .systemPink : .systemGray*/
        
       
        
        
        
        if isFilled {
            image = UIImage(systemName: "heart.fill")!
            
            
            guard let trackID = trackID else {
                return
            }
            
            
            let newObject = ObjectTrack()
            newObject.trackID = trackID
            
            try! realm.write {
                realm.add(newObject)
            }
           
            DispatchQueue.main.async {
                self.delegatecik?.didLoadInitialTracks()
            }
            do {
                        let realm = try Realm()
                        let results = realm.objects(ObjectTrack.self)
                       
                    } catch let error {
                        print("Error retrieving track IDs: \(error.localizedDescription)")
                    }
            
            
            
            tintColor = .systemPink
        } else {
            image = UIImage(systemName: "heart")!
            
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
            
           
           
            
            tintColor = .systemGray
        }
        

        
        
        heartButton.setBackgroundImage(image, for: .normal)
        
        
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(views: trackImage, trackName, trackTime,heartButton)
        
        trackImage.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 100, height: 0)
        heartButton.anchor(top: contentView.topAnchor, bottom: nil, leading: nil, trailing: contentView.trailingAnchor, paddingTop: 15, paddingBottom: 0, paddingLeft: 0, paddingRight: -15, width: 30, height: 30)
        trackName.anchor(top: contentView.topAnchor, bottom: nil, leading: trackImage.trailingAnchor, trailing: heartButton.leadingAnchor, paddingTop: 15, paddingBottom: 0, paddingLeft: 15, paddingRight: 0, width: 0, height: 30)
        trackTime.anchor(top: trackName.bottomAnchor, bottom: contentView.bottomAnchor, leading: trackImage.trailingAnchor, trailing: contentView.trailingAnchor, paddingTop: 0, paddingBottom: -20, paddingLeft: 10, paddingRight: 0, width: 0, height: 0)
        
       // print(trackID)
    
        
    }
    
    
    
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    func configure(viewModel: TrackCollectionCellViewModel){
        trackName.text = viewModel.trackName
        trackTime.text = "\(viewModel.trackDuration)"
        trackID = viewModel.trackID
        
        var duration: String = ""
        let minute = viewModel.trackDuration/60
        var seconds = "\(viewModel.trackDuration%60)"
        if Int(seconds)! < 10{
            seconds = "0\(seconds)"
            print(seconds)
        }
        duration = "\(minute).\(seconds)"
        self.trackTime.text = duration
        
        
        if let object = realm.objects(ObjectTrack.self).filter("trackID == %@", viewModel.trackID).first {
            isFilled.toggle()
            //print(object)
          //  print("evet var")
            image = UIImage(systemName: "heart.fill")!
            tintColor = .systemPink
            heartButton.setBackgroundImage(image, for: .normal)
           // isFilled.toggle()
        }
        
        viewModel.fetchImage { [weak self] result in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    self?.trackImage.image = UIImage(data: data)
                }
                
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
    
}









