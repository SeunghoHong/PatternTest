
import Foundation

import RxSwift
import RxCocoa


final class MainViewModel {

    let clipButtonTapped = PublishRelay<Void>()

    weak var coordinatorDelegate: MainCoordinatorDelegate?
    private var disposeBag = DisposeBag()

    init() {
        self.bind()
    }
}


extension MainViewModel {

    private func bind() {
        self.clipButtonTapped
            .debug()
            .bind { [weak self] in
                self?.coordinatorDelegate?.goToClip()
            }
            .disposed(by: self.disposeBag)
    }
}
