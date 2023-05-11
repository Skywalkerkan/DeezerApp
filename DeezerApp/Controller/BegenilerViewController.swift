//
//  BegenilerViewController.swift
//  DeezerApp
//
//  Created by Erkan on 11.05.2023.
//

import UIKit

import UIKit
import AVFoundation


class BegenilerViewController: UIViewController, BegeniListViewDelegate {

    

    var player:AVPlayer?
    var playerItem:AVPlayerItem?


    let begeniListView = BegeniListView()
    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        begeniListView.delegate = self
       // view.backgroundColor = .cyan
        

    
        view.addSubview(begeniListView)
        
        
        begeniListView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        begeniListView.backgroundColor = .red
        
        

        
    }
    
    func listViewTrack(trackView: BegeniListView, track: TrackData) {
        guard let previewURL = URL(string: track.preview) else{
            return
        }
        let playerItem:AVPlayerItem = AVPlayerItem(url: previewURL)
        self.player = AVPlayer(playerItem: playerItem)
        if player?.rate == 0
                {
                    player!.play()
            print("Çalıyor")
                    //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
                } else {
                    player!.pause()
                    print("Çalmıyor")
                    //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
                }
    }
    
    
 
    }
    
