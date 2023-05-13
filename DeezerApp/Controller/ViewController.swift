//
//  ViewController.swift
//  DeezerApp
//
//  Created by Erkan on 9.05.2023.
//

import UIKit

class ViewController: UIViewController, GenreListViewDelegate {

    

    
    private let genresListView = GenreListView()
    
    var GenresData: [Genre] = []
    var artistsData: [SingleArtist] = []
    var singleArtist: SingleArtist?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Kategoriler"
        genresListView.delegate = self
        view.addSubview(genresListView)
        genresListView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        
        
        tabBarItem.title = ""
        
    
        
    }
    
    func listViewGenre(genreView: GenreListView, genreID: Int) {
        //Detail
        //print(genreID)
        let VC = ArtistsViewController()
        VC.id = genreID
        
        self.navigationController?.pushViewController(VC, animated: true)
    }


}

