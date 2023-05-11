//
//  ArtistCollectionViewCell.swift
//  DeezerApp
//
//  Created by Erkan on 10.05.2023.
//

import UIKit

class ArtistCollectionViewCell: UICollectionViewCell {
 
    static let identifier = "ArtistCollectionViewCell"
    
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .secondarySystemBackground
        
        
        return imageView
    }()
    
    
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .black)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
       // label.text = "Erkan"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        contentView.addSubviews(views: imageView, artistLabel)
        
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 3
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.clipsToBounds = true
        
        imageView.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        artistLabel.anchor(top: nil, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 50)
        
        
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        artistLabel.text = nil
    }
    
    
    required init(coder: NSCoder) {
        fatalError("Unsupported Cell")
    }
    
    
    
    func configure(viewModel: ArtistCollectionViewCellViewModel){
        artistLabel.text = viewModel.artistName
        
        viewModel.fetchImage { [weak self] result in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
                
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
    
}



