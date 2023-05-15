//
//  TrackersViewController.swift
//  DeezerApp
//
//  Created by Erkan on 11.05.2023.
//

import UIKit
import AVFoundation


class TrackersViewController: UIViewController, TrackListViewDelegate {

    var player:AVPlayer?
    var playerItem:AVPlayerItem?


    let trackListView = TrackListView()
    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        trackListView.delegate = self
        view.backgroundColor = .white
        
    
        view.addSubview(trackListView)
        trackListView.byTrackID = id
        
        trackListView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        
        

        
    }

    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.popViewController(animated: true)
  
    }
    
    
    
   
    
    
    
    func listViewTrack(trackView: TrackListView, track: TrackData) {
        
        
        guard let preview = track.preview else{
            return
        }
        
        guard let previewURL = URL(string: preview) else{
            return
        }
        
        let playerItem:AVPlayerItem = AVPlayerItem(url: previewURL)
        self.player = AVPlayer(playerItem: playerItem)
        if player?.rate == 0
                {
                    player!.play()
            
                    //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
                } else {
                    player!.pause()
                    
                    //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
                }
            }
    }
    
    
    
    



