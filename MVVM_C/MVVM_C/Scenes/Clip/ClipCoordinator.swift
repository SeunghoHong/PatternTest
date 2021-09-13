
import UIKit


final class ClipCoordinator: Coordinator {
    var parent: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let clipViewController = ClipViewController()

        self.navigationController.isNavigationBarHidden = true
        self.navigationController.pushViewController(
            clipViewController,
            animated: true
        )
    }
}


extension MainCoordinator {

}

