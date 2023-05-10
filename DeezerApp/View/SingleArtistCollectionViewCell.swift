//
//  SingleArtistCollectionViewCell.swift
//  DeezerApp
//
//  Created by Erkan on 10.05.2023.
//

import UIKit

class SingleArtistCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SingleArtistCollectionViewCell"
    
    private let albumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .purple
        return imageView
    }()
    
    
    private let releaseDate: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "15 ağustos"
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    private let albumName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Merhaba"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubviews(views: albumName, albumImage, releaseDate)
        contentView.layer.cornerRadius = 20
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 2
        
        
        print("girdi")
        
        albumImage.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 100, height: 0)
        albumName.anchor(top: contentView.topAnchor, bottom: nil, leading: albumImage.trailingAnchor, trailing: contentView.trailingAnchor, paddingTop: 20, paddingBottom: 0, paddingLeft: 10, paddingRight: -5, width: 0, height: 0)
        releaseDate.anchor(top: albumName.bottomAnchor, bottom: nil, leading: albumName.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: 10, paddingBottom: 10, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        
        
        
    }
    
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    func configure(viewModel: SingleCollectionCellViewModel){
        albumName.text = viewModel.albumName
        
        viewModel.fetchImage { [weak self] result in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    self?.albumImage.image = UIImage(data: data)
                }
                
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
    
    
}
