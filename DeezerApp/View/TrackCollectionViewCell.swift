//
//  TrackCollectionViewCell.swift
//  DeezerApp
//
//  Created by Erkan on 11.05.2023.
//

import UIKit

class TrackCollectionViewCell: UICollectionViewCell {
    
    var isFilled = false
    static let identifier = "TrackCollectionViewCell"
    
    
    var trackID: Int?
    
    private let trackImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .purple
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
    
    
    
    
    

    
    @objc func begenClicked(){
        
        isFilled.toggle()
        var image = UIImage()
        /*let image = isFilled ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        tintColor = isFilled ? .systemPink : .systemGray*/
        
        if isFilled{
            image = UIImage(systemName: "heart.fill")!
            tintColor = .systemPink
        }
        else{
            image = UIImage(systemName: "heart")!
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
        trackTime.anchor(top: trackName.bottomAnchor, bottom: contentView.bottomAnchor, leading: trackImage.trailingAnchor, trailing: contentView.trailingAnchor, paddingTop: 0, paddingBottom: -20, paddingLeft: 5, paddingRight: 0, width: 0, height: 0)
        
        
        
    }
    
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    func configure(viewModel: TrackCollectionCellViewModel){
        trackName.text = viewModel.trackName
        trackTime.text = "\(viewModel.trackDuration)"
        
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
