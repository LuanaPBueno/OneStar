//
//  ViewController.swift
//  OneStar
//
//  Created by Luana Bueno on 10/02/25.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    @IBOutlet var cameraControlView: UIView!
    
    var player: AVPlayer?
        var playerLayer: AVPlayerLayer?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Caminho do vídeo (altere para a URL correta)
            guard let videoURL = Bundle.main.url(forResource: "video", withExtension: "mp4") else {
                print("Vídeo não encontrado!")
                return
            }
            
            // Configurar o player
            player = AVPlayer(url: videoURL)
            playerLayer = AVPlayerLayer(player: player)
            
            // Ajustar tamanho do player para caber na UIView
            playerLayer?.frame = cameraControlView.bounds
            playerLayer?.videoGravity = .resizeAspectFill
            
            // Adicionar a camada do player na view
            if let playerLayer = playerLayer {
                cameraControlView.layer.addSublayer(playerLayer)
            }
            
            // Iniciar a reprodução
            player?.play()
        }

}


#Preview{
    CameraViewController()
}
