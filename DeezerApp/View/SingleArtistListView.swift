//
//  SingleArtistListView.swift
//  DeezerApp
//
//  Created by Erkan on 10.05.2023.
//

import UIKit



protocol AlbumListViewDelegate: AnyObject{
    
    func listViewAlbum(albumView: SingleArtistListView, album: Album)
}




final class SingleArtistListView: UIView{
    
    
    
    
    
    static let shared = SingleArtistListView()
    private let viewModel = SingleArtistViewModel()
    public weak var delegate: AlbumListViewDelegate?
    
    private let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SingleArtistCollectionViewCell.self, forCellWithReuseIdentifier: SingleArtistCollectionViewCell.identifier)
        collectionView.register(MyHeaderFooterClass.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID")

        return collectionView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .purple
        return imageView
    }()
    
    
    var byIDArtist: Int = 0{
        didSet{
            viewModel.fetchSingleArtist(artistID: byIDArtist)
            
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(views: collectionView)
        viewModel.delegate = self
        
        
        addConstraints()
        collectionViewSetup()
        
        
    }
    
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    private func addConstraints(){
   
        collectionView.anchor(top: safeAreaLayoutGuide.topAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, paddingTop: 15, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        
    }
    
    private func collectionViewSetup(){
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
        
        
        
    }
    
    
    
    
    
    
    
    
    
}


extension SingleArtistListView: AlbumViewModelDelegate{
  
    func didSelectAlbum(album: Album) {
        delegate?.listViewAlbum(albumView: self, album: album)
    }
    
    
   
    
    func didLoadInitialArtist() {
        collectionView.reloadData()
    }
    
    
    
    
    
}
