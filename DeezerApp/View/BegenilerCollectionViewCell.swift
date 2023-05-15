//
//  BegenilerCollectionViewCell.swift
//  DeezerApp
//
//  Created by Erkan on 12.05.2023.
//

import UIKit
import RealmSwift
import Alamofire


class BegenilerCollectionViewCell: UICollectionViewCell {
    
    let realm = try! Realm()
   
    static let identifier = "TrackCollectionViewCell"
    
    private let trackImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
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
    
    var trackID: Int = 0
    var trackSira: Int = 0
    

    private let heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let imageHeart = UIImageView(image: UIImage(systemName: "heart.fill"))
        button.setBackgroundImage(imageHeart.image?.withTintColor(.systemRed, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(begenClicked), for: .touchUpInside)
        return button
    }()
    
    @objc func begenClicked(){
        
        
            print("sil")
    
               
            let objectsToDelete = realm.objects(ObjectTrack.self).filter("trackID == %@", trackID)
            
            try! realm.write {
                realm.delete(objectsToDelete)
            }
        
        
        

           
 
            

        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(views: trackImage, trackName, trackTime,heartButton)
        
        trackImage.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 100, height: 0)
        heartButton.anchor(top: contentView.topAnchor, bottom: nil, leading: nil, trailing: contentView.trailingAnchor, paddingTop: 15, paddingBottom: 0, paddingLeft: 0, paddingRight: -15, width: 30, height: 30)
        trackName.anchor(top: contentView.topAnchor, bottom: nil, leading: trackImage.trailingAnchor, trailing: heartButton.leadingAnchor, paddingTop: 15, paddingBottom: 0, paddingLeft: 15, paddingRight: 0, width: 0, height: 30)
        trackTime.anchor(top: trackName.bottomAnchor, bottom: contentView.bottomAnchor, leading: trackImage.trailingAnchor, trailing: contentView.trailingAnchor, paddingTop: 0, paddingBottom: -20, paddingLeft: 10, paddingRight: 0, width: 0, height: 0)
        
     
    
        
    }
    
    
    
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }
    var begeniler: [TrackData] = []
    
    
    var image: String = "" {
        didSet{
            image = "https://e-cdns-images.dzcdn.net/images/cover/" + image + "/500x500-000000-80-0-0.jpg"
            guard let imageurl = URL(string: image) else{
                return
            }
            
            AF.request(imageurl).responseData { response in
                switch response.result{
                case .success(let imageData):
                   // completion(.success(imageData))
                    self.trackImage.image = UIImage(data: imageData)
                case .failure(let error):
                   // completion(.failure(error))
                    print(error.localizedDescription)
                    
                }
            }
            
        }
    }
    
    
    var begenilerCopy: [TrackData] = []
    
    
    func configure(trackData: TrackData, trackSira: Int, begeniler: [TrackData]){
        self.trackName.text = trackData.title
        begenilerCopy = begeniler
        
        guard let trackID = trackData.id else{
            return
        }
        
        self.trackID = trackID
        self.trackSira = trackSira
        self.begeniler = begeniler
        self.image = trackData.md5Image!
        
        guard let durationData = trackData.duration else{
            return
        }
        
        var duration: String = ""
        let minute = durationData/60
        var seconds = "\(durationData%60)"
        if Int(seconds)! < 10{
            seconds = "0\(seconds)"
            
        }
        duration = "\(minute).\(seconds)"
        self.trackTime.text = duration
        
    }
    
}
