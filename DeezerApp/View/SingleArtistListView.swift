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
    
    var imageURL: String?{
        didSet{
           // print(imageURL)
            guard let imageURL = imageURL else{return}
            APICaller.shared.loadImage(from: imageURL) { data in
                guard let data = data else{
                    return
                }
                print("Görselll")
                print(data)
                
                print(imageURL)
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
               
            }
            
            
        }
    }
    
    
    
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
         //   print(byIDArtist)
          //  print("Yukardaki")
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
        //backgroundColor = .gray
        
        
    }
    
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    private func addConstraints(){
       // imageView.anchor(top: safeAreaLayoutGuide.topAnchor, bottom: nil, leading: safeAreaLayoutGuide.leadingAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 200)
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
    
    
    /*func didSelectArtist(artist: SingleArtist) {
        delegate?.listViewArtists(artistView: self, artist: artist)
    }*/
    
    func didLoadInitialArtist() {
        collectionView.reloadData()
    }
    
    
    
    
    
}
