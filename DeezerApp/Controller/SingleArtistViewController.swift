//
//  SingleArtistViewController.swift
//  DeezerApp
//
//  Created by Erkan on 10.05.2023.
//

import UIKit

class SingleArtistViewController: UIViewController, AlbumListViewDelegate {


    let singleArtistView = SingleArtistListView()
    var id: Int = 0
    private let singleArtistViewModel  = SingleArtistViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(singleArtistView)
        
        singleArtistView.byIDArtist = id
        singleArtistView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        singleArtistView.delegate = self
        
        
        
        view.backgroundColor = .white
    }
    
    func listViewAlbum(albumView artistView: SingleArtistListView, album: Album) {
       
        let VC = TrackersViewController()
        VC.title = album.title
        VC.id = album.id
        navigationController?.pushViewController(VC, animated: true)
    }
    
    

    

}
