
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

    var reactor: MainViewReactor?
    var disposeBag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
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
        print(#function)
        self.view.addSubview(self.plusButton)
        self.view.addSubview(self.minusButton)
        self.view.addSubview(self.valueLabel)
    }

    private func layout() {
        print(#function)
        self.minusButton.pin.left(16.0).vCenter().sizeToFit()
        self.plusButton.pin.right(16.0).vCenter().sizeToFit()
        self.valueLabel.pin.horizontallyBetween(self.minusButton, and: self.plusButton).vCenter().height(20.0)
//        self.valueLabel.pin.center().sizeToFit(.content)
    }
}
