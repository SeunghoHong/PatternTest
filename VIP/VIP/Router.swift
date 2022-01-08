
import Foundation
import UIKit


class Router {

    private var navigationController: UINavigationController


    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        self.showMovieListView()
    }
}


extension Router {

    private func showMovieListView() {
        let viewController = MovieListViewController()
        let presenter = MovieListPresenter(viewController: viewController)
        let interactor = MovieListInteractor(presenter: presenter)
        viewController.interactor = interactor

        self.navigationController.pushViewController(viewController, animated: true)
    }
}
