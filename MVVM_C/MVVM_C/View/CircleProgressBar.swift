
import UIKit


final class CircleProgressBar: UIView {

    private var progressLayer = CAShapeLayer()
    private var backgroundMask = CAShapeLayer()

    private var lineWidth: CGFloat = 2.0
    var progress: CGFloat = 0.0 {
        didSet { self.setNeedsDisplay() }
    }


    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init() {
        super.init(frame: .zero)

        self.setup()
    }

    private func setup() {
        self.backgroundMask.lineWidth = self.lineWidth
        self.backgroundMask.fillColor = nil
        self.backgroundMask.strokeColor = UIColor.black.cgColor
        self.layer.mask = self.backgroundMask

        self.progressLayer.lineWidth = self.lineWidth
        self.progressLayer.fillColor = nil
        self.layer.addSublayer(self.progressLayer)
        self.layer.transform = CATransform3DMakeRotation(CGFloat(90.0 * .pi / 180.0), 0.0, 0.0, -1.0)
    }

    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(ovalIn: rect.insetBy(dx: self.lineWidth / 2, dy: self.lineWidth / 2))
        self.backgroundMask.path = circlePath.cgPath

        self.progressLayer.path = circlePath.cgPath
        self.progressLayer.lineCap = .round
        self.progressLayer.strokeStart = 0.0
        self.progressLayer.strokeEnd = self.progress
        self.progressLayer.strokeColor = UIColor.red.cgColor
    }
}

