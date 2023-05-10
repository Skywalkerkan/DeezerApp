//
//  ArtistsViewController.swift
//  DeezerApp
//
//  Created by Erkan on 10.05.2023.
//

import UIKit






class ArtistsViewController: UIViewController, ArtistsListViewDelegate {

    
 
    

    private let ArtistListView = ArtistsListView()
    private let artistViewModel  = ArtistsListViewModel()
    
    var id: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ArtistListView.delegate = self
        
        
        
        
        view.addSubview(ArtistListView)
       // print(id)
  
        ArtistListView.byIDArtist = id
        
        
        ArtistListView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        
        
        view.backgroundColor = .orange
        
        
    }
    
    
    func listViewArtists(artistView genreView: ArtistsListView, artist: SingleArtist) {
        let VC = SingleArtistViewController()
        VC.id = artist.id
        print(artist.name)
        VC.title = artist.name
        navigationController?.pushViewController(VC, animated: true)
    }

 

}


