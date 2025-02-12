import AVKit
import AVFoundation

class CustomVideoViewController: UIViewController {
    
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var progressBar: UIView!
    var progressBarWidth: CGFloat = 0
    var animationDuration: Double = 4.0 // Duração da animação da barra (4 segundos)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adiciona o player de vídeo
        if let videoPath = Bundle.main.path(forResource: "IMG_4984", ofType: "mp4") {
            player = AVPlayer(url: URL(fileURLWithPath: videoPath))
            playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = view.bounds
            view.layer.addSublayer(playerLayer)
            
            // Barra amarela no topo (ajustada para não ficar muito longe de cima)
            progressBar = UIView()
            progressBar.frame = CGRect(x: 0, y: 72, width: 0, height: 8) // Ajuste na posição
            progressBar.backgroundColor = .yellow
            view.addSubview(progressBar)
            
            // Inicia a animação da barra
            animateProgressBar()
            
            // Inicia o vídeo
            player.play()
        }
    }
    
    func animateProgressBar() {
        // Configura a largura total da tela
        progressBarWidth = view.bounds.width
        
        // Anima a barra para preencher a largura total em 4 segundos
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveLinear, animations: {
            self.progressBar.frame.size.width = self.progressBarWidth
        }, completion: { _ in
            // A animação terminou
        })
    }
    
    @objc func dismissVideo() {
        self.dismiss(animated: true, completion: nil)
    }
}

