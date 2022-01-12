
import UIKit

import RxCocoa
import RxSwift
import ReactorKit
import PinLayout
import FlexLayout


final class MainViewController: UIViewController, View {

    private let plusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("+", for: .normal)

        return button
    }()

    private let minusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("-", for: .normal)

        return button
    }()

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .black
        label.textAlignment = .center

        return label
    }()

    private let profileButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("PROFILE", for: .normal)

        return button
    }()

    var reactor: MainViewReactor?
    var disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
        self.bind()

        if let reactor = reactor {
            self.bind(reactor: reactor)
        }
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

    func bind(reactor: MainViewReactor) {
        print(#function)
        plusButton.rx.tap
            .map { Reactor.Action.plus }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)

        minusButton.rx.tap
            .map { Reactor.Action.minus }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)

        reactor.state.map { $0.value }
            .distinctUntilChanged()
            .map { "\($0)" }
            .bind(to: self.valueLabel.rx.text)
            .disposed(by: self.disposeBag)

//        reactor.state.map { $0.value }
//            .distinctUntilChanged()
//            .bind { [weak self] _ in
//                self?.layout()
//            }
//            .disposed(by: self.disposeBag)
    }
}


extension MainViewController {

    private func setup() {
        self.title = "Main"

        self.view.addSubview(self.plusButton)
        self.view.addSubview(self.minusButton)
        self.view.addSubview(self.valueLabel)
        self.view.addSubview(self.profileButton)
    }

    private func layout() {
        print(#function)
        self.minusButton.pin
            .left(16.0)
            .vCenter()
            .sizeToFit()

        self.plusButton.pin
            .right(16.0)
            .vCenter()
            .sizeToFit()

        self.valueLabel.pin
            .horizontallyBetween(self.minusButton, and: self.plusButton)
            .vCenter()
            .height(20.0)

        self.profileButton.pin
            .below(of: self.valueLabel)
            .hCenter()
            .marginTop(32.0)
            .sizeToFit()
    }

    private func bind() {
        self.profileButton.rx.tap
            .bind { [weak self] _ in
                self?.navigateToProfile()
            }
            .disposed(by: self.disposeBag)
    }
}


extension MainViewController {

    private func navigateToProfile() {
        let profileViewController = ProfileViewController()
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
}
