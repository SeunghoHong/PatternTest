
import UIKit

import RxSwift


final class AppCoordinator: Coordinator {
    var parent: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController


    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        self.goToMain()
    }
}


extension AppCoordinator {

    private func goToMain() {
        let mainCoordinator = MainCoordinator(
            navigationController: self.navigationController
        )

//        mainCoordinator.start()
//        self.children.append(mainCoordinator)
        self.start(coordinator: mainCoordinator)
    }
}
