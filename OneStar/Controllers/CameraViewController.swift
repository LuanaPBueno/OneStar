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
        // Verifica se o player está em reprodução
                if let player = player {
                    if player.rate != 0, player.error == nil {
                        // Se o vídeo estiver rodando, pausa
                        player.pause()
                        print("Vídeo pausado")
                    } else {
                        // Se o vídeo estiver pausado, despausa
                        player.play()
                        print("Vídeo despausado")
                    }
                }
    }
    
    var player: AVPlayer?
   var playerLayer: AVPlayerLayer?
   
   override func viewDidLoad() {
       super.viewDidLoad()
       
       // Caminho do vídeo (altere para a URL correta)
       guard let videoURL = Bundle.main.url(forResource: "IMG_4984", withExtension: "mp4") else {
           print("Vídeo não encontrado!")
           return
       }
       
       // Configurar o player
       player = AVPlayer(url: videoURL)
       playerLayer = AVPlayerLayer(player: player)
       
       // Ajustar tamanho do player para caber na UIView
       playerLayer?.frame = view.bounds
       playerLayer?.videoGravity = .resizeAspectFill
       
       // Adicionar a camada do player na view
       if let playerLayer = playerLayer {
           view.layer.addSublayer(playerLayer)
           playerLayer.zPosition = -1 // Garante que o vídeo fique atrás de outros elementos
       }
       
       // Iniciar a reprodução
       player?.play()
   }
}



#Preview{
    CameraViewController()
}
