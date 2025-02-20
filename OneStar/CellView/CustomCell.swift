import UIKit

class Cell: UITableViewCell {
    
    
    @IBOutlet weak var toggleButton: UIButton!
    private var isFilled = false
    private let innerCircleLayer = CAShapeLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        addInnerCircle()
        toggleButton.addTarget(self, action: #selector(toggleFill), for: .touchUpInside) // Conectar evento
    }

    private func addInnerCircle() {
        let circleSize = toggleButton.frame.width * 0.5
        let circlePath = UIBezierPath(ovalIn: CGRect(
            x: (toggleButton.bounds.width - circleSize) / 2,
            y: (toggleButton.bounds.height - circleSize) / 2,
            width: circleSize,
            height: circleSize
        ))

        innerCircleLayer.path = circlePath.cgPath
        innerCircleLayer.strokeColor = UIColor.white.cgColor
        innerCircleLayer.fillColor = UIColor.clear.cgColor
        innerCircleLayer.lineWidth = 2

        toggleButton.layer.addSublayer(innerCircleLayer)
    }

    @objc private func toggleFill() {
        isFilled.toggle()
        innerCircleLayer.fillColor = isFilled ? UIColor.white.cgColor : UIColor.clear.cgColor
    }
}


