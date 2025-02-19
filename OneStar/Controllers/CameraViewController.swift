//
//  ViewController.swift
//  OneStar
//
//  Created by Luana Bueno on 10/02/25.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    
    @IBAction func stoppingVideo(_ sender: Any) {
                if let player = player {
                    if player.rate != 0, player.error == nil {
                        player.pause()
                        print("Vídeo pausado")
                    } else {
                        player.play()
                        print("Vídeo despausado")
                    }
                }
    }
    
    var player: AVPlayer?
   var playerLayer: AVPlayerLayer?
   
   override func viewDidLoad() {
       super.viewDidLoad()
       
       guard let videoURL = Bundle.main.url(forResource: "IMG_4984", withExtension: "mp4") else {
           print("Vídeo não encontrado!")
           return
       }
       
       player = AVPlayer(url: videoURL)
       playerLayer = AVPlayerLayer(player: player)
       
       playerLayer?.frame = view.bounds
       playerLayer?.videoGravity = .resizeAspectFill
       
       if let playerLayer = playerLayer {
           view.layer.addSublayer(playerLayer)
           playerLayer.zPosition = -1
       }
       
       player?.play()
   }
}



#Preview{
    CameraViewController()
}
