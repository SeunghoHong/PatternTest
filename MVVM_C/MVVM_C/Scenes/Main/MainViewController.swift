
import UIKit

import RxSwift
import PinLayout


final class MainViewController: UIViewController {

    private let headerView = UIView()
    private let titleLabel = UILabel()

    private let clipButton = UIButton()

    private var viewModel: MainViewModel?
    private var disposeBag = DisposeBag()


    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(with viewModel: MainViewModel? = nil) {
        print(#function)
        super.init(nibName: nil, bundle: nil)

        self.bind(with: viewModel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.layout()
    }
}


extension MainViewController {

    private func setup() {
        self.view.backgroundColor = .white

        self.headerView.backgroundColor = .black.withAlphaComponent(0.2)
        self.view.addSubview(self.headerView)

        self.titleLabel.text = "Main"
        self.titleLabel.textColor = .white
        self.headerView.addSubview(self.titleLabel)

        self.clipButton.setTitle("go to clip", for: .normal)
        self.clipButton.setTitleColor(.white, for: .normal)
        self.clipButton.backgroundColor = .black
        self.clipButton.contentEdgeInsets = UIEdgeInsets(
            top: 12.0, left: 16.0, bottom: 12.0, right: 16.0
        )
        self.view.addSubview(self.clipButton)
    }

    private func layout() {
        self.headerView.pin
            .top(self.view.pin.safeArea.top)
            .horizontally()
            .height(58.0)

        self.titleLabel.pin
            .center()
            .sizeToFit()

        self.clipButton.pin
            .center()
            .sizeToFit()
    }

    private func bind() {
        
    }
}


extension MainViewController {

    func bind(with viewModel: MainViewModel?) {
        guard let viewModel = viewModel else { return }

        self.viewModel = viewModel

        self.clipButton.rx.tap
            .bind(to: viewModel.clipButtonTapped)
            .disposed(by: self.disposeBag)
    }
}
