//
//  GenreCollectionViewCell.swift
//  DeezerApp
//
//  Created by Erkan on 9.05.2023.
//

import Foundation
import UIKit

class GenreCollectionViewCell: UICollectionViewCell{
    
    static let identifier = "GenreCollectionViewCell"
    
    
    
    private let genreImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let genreLabel: UILabel = {
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
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(views: genreImageView, genreLabel)
        
        addConstraints()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("Nothing")
    }
    
    
    private func addConstraints(){
      
        genreImageView.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        genreLabel.anchor(top: nil, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 50)
        
        genreLabel.text = "Erkan"
        genreImageView.backgroundColor = .green
        
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        genreImageView.image = nil
        genreLabel.text = nil
    }
    
    
    func configure(viewModel: GenreCollectionViewCellViewModel){
        
        
        genreLabel.text = viewModel.genreName
        viewModel.fetchImage { [weak self] result in
            switch result{
            case .success(let imageData):
                DispatchQueue.main.async {
                    self?.genreImageView.image = UIImage(data: imageData)
                }
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
    
    
    
    
    
}
