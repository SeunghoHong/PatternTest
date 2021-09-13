
import UIKit


protocol MainCoordinatorDelegate: AnyObject {
    func goToClip()
}


final class MainCoordinator: Coordinator {
    var parent: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainViewController = MainViewController()
        let mainViewModel = MainViewModel()
        mainViewModel.coordinatorDelegate = self
        mainViewController.bind(with: mainViewModel)

        self.navigationController.isNavigationBarHidden = true
        self.navigationController.pushViewController(
            mainViewController,
            animated: true
        )
    }
}


extension MainCoordinator: MainCoordinatorDelegate {

    func goToClip() {
        print(#function)
        let clipCoordinator = ClipCoordinator(
            navigationController: self.navigationController
        )

//        clipCoordinator.start()
        self.start(coordinator: clipCoordinator)
    }
}
