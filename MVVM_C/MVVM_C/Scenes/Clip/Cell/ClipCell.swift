
import UIKit
import AVFoundation

import RxSwift
import RxCocoa
import RxGesture
import PinLayout
import FlexLayout


final class ClipCell: UICollectionViewCell {

    private let backgroundImageView = UIImageView()
    private let circleProgressBar = CircleProgressBar()
    private let profileImageView = UIImageView()

    private let infoView = UIView()
    private let nicknameLabel = UILabel()
    private let titleLabel = UILabel()

    private let followButton = UIButton()
    private let likeButton = UIButton()
    private let shareButton = UIButton()

    private let commentTextField = UITextField()
    private var commentTextFieldBottonOffset: CGFloat = 20.0

    private var player: AVPlayer?

    private var disposeBag = DisposeBag()


    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
        self.setupFlex()
        self.bind()

        self.prepare()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layout()
    }
}


extension ClipCell {

    private func setup() {
        self.contentView.backgroundColor = .white

        self.backgroundImageView.backgroundColor = .lightGray
        self.contentView.addSubview(self.backgroundImageView)

        self.circleProgressBar.backgroundColor = .black
        self.circleProgressBar.progress = 0.0
        self.contentView.addSubview(self.circleProgressBar)

        self.profileImageView.clipsToBounds = true
        self.profileImageView.backgroundColor = .blue
        self.profileImageView.layer.cornerRadius = 100.0
        self.profileImageView.layer.masksToBounds = true
        self.profileImageView.clipsToBounds = true
        self.contentView.addSubview(self.profileImageView)

        self.infoView.backgroundColor = .cyan
        self.contentView.addSubview(self.infoView)

        self.nicknameLabel.backgroundColor = .yellow
        self.nicknameLabel.textColor = .black
        self.nicknameLabel.text = "Apple Event"

        self.titleLabel.backgroundColor = .green
        self.titleLabel.textColor = .black
        self.titleLabel.text = "Introducing the new MacBook Air, 13‑inch MacBook Pro, and Mac mini, all with the Apple M1 chip."

        self.followButton.backgroundColor = .red
        self.likeButton.backgroundColor = .blue
        self.shareButton.backgroundColor = .yellow

        self.commentTextField.backgroundColor = .red
        self.contentView.addSubview(self.commentTextField)
    }

    private func setupFlex() {
        self.infoView.flex
            .direction(.row)
            .marginHorizontal(16.0)
            .alignItems(.baseline)
            .define { flex in
                flex.addItem()
                    .direction(.column)
                    .shrink(1)
                    .define { flex in
                        flex.addItem(self.nicknameLabel)

                        flex.addItem(self.titleLabel)
                            .marginTop(8.0)
                    }

                flex.addItem()
                    .direction(.column)
                    .marginLeft(28.0)
                    .define { flex in
                        flex.addItem(self.followButton)
                            .size(40)

                        flex.addItem(self.likeButton)
                            .marginTop(24.0)
                            .size(40)

                        flex.addItem(self.shareButton)
                            .marginTop(24.0)
                            .size(40)
                    }
            }
    }

    private func layout() {
        self.circleProgressBar.pin
            .top(68.0)
            .margin(12.0)
            .hCenter()
            .size(208.0)

        self.profileImageView.pin
            .top(68.0)
            .marginTop(16.0)
            .hCenter()
            .size(200.0)

        self.backgroundImageView.pin
            .all()

        self.infoView.pin
            .horizontally()

        self.infoView.flex
            .layout(mode: .adjustHeight)

        self.infoView.pin
            .bottom(self.contentView.pin.safeArea.bottom + 86.0)

        self.commentTextField.pin
            .bottom(self.contentView.pin.safeArea.bottom + self.commentTextFieldBottonOffset)
            .horizontally(16.0)
            .height(46.0)
    }

    private func bind() {
        self.profileImageView.rx.tapGesture()
            .bind { [weak self] _ in
                self?.endEditing(false)
            }
            .disposed(by: self.disposeBag)
    }
}


extension ClipCell {

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        self.layout()

        return self.contentView.frame.size
    }
}


extension ClipCell {

    func willDisplay() {
        print(#function)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillChange(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillChange(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        self.player?.play()
    }

    func didEndDisplaying() {
        print(#function)
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        self.player?.pause()
    }

    @objc func keyboardWillChange(_ notification: Notification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
              let beginFrame = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue,
              let endFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }

        print("\(#function) \(beginFrame.cgRectValue.height) \(endFrame.cgRectValue.height)")

        if notification.name == UIResponder.keyboardWillShowNotification {
            self.commentTextFieldBottonOffset = endFrame.cgRectValue.height + 20.0
        } else {
            self.commentTextFieldBottonOffset = 20.0
        }

        UIView.animate(
            withDuration: duration,
            delay: 0.0,
            options: UIView.AnimationOptions(rawValue: curve)
        ) {
            self.layout()
        }
    }
}


extension ClipCell {

    func prepare() {
        guard let url = Bundle.main.url(forResource: "file_example_MP3_700KB", withExtension: "mp3") else { return }

        self.player = AVPlayer(url: url)
        self.player?.addPeriodicTimeObserver(
            forInterval: CMTimeMake(value: 33, timescale: 1000),
            queue: nil
        ) { [weak self] time in
            guard let duration = self?.player?.currentItem?.duration else { return }

            let progress = CGFloat(time.seconds / duration.seconds)
            self?.circleProgressBar.progress = progress
        }
    }
}
