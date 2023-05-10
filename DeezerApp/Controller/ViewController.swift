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
        
       title = "Erkan"
        genresListView.delegate = self
        view.addSubview(genresListView)
        genresListView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        
        
        /*APICaller.shared.fetchGenres { result in
            switch result{
            case .success(let GenreData):
                self.GenresData = GenreData.data
              //  print(self.GenresData)
            case .failure(let error):
                print(error)
            }
        }
        
        APICaller.shared.fetchArtists(genreID: 0) { result in
            switch result{
            case .success(let artistData):
                self.artistsData = artistData.data
             //   print(self.artistsData)
            case .failure(let error):
                print(error)
                
            }
        }
        
        APICaller.shared.fetchSingleArtist(artistID: 5331963) { result in
            switch result{
            case .success(let singleArtistData):
                print(singleArtistData)
            case .failure(let error):
                print(error)
            }
        }*/
        
    
        
    }
    
    func listViewGenre(genreView: GenreListView, genreID: Int) {
        //Detail
        //print(genreID)
        let VC = ArtistsViewController()
        VC.id = genreID
        self.navigationController?.pushViewController(VC, animated: true)
    }


}

