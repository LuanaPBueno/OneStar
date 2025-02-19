import AVKit
import AVFoundation

class CustomVideoViewController: UIViewController {
    
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var progressBar: UIView!
    var progressBarWidth: CGFloat = 0
    var animationDuration: Double = 7.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let videoPath = Bundle.main.path(forResource: "IMG_4984", ofType: "mp4") {
            player = AVPlayer(url: URL(fileURLWithPath: videoPath))
            playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = view.bounds
            playerLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(playerLayer)
            
            progressBar = UIView()
            progressBar.frame = CGRect(x: 0, y: 0, width: 0, height: 8)
            progressBar.backgroundColor = .purple
            view.addSubview(progressBar)
            
            NotificationCenter.default.addObserver(self, selector: #selector(videoDidEnd), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
            
            player.play()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateProgressBar()
    }
    
    func animateProgressBar() {
        progressBarWidth = view.bounds.width
        
        // Anima a barra para preencher a largura total em 4 segundos
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveLinear, animations: {
            self.progressBar.frame.size.width = self.progressBarWidth
        }, completion: { _ in
        })
    }

    @objc func videoDidEnd() {
            dismiss(animated: true, completion: nil)
        }
}

