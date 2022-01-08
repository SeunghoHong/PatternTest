
import Foundation


final class MovieListPresenter {

    private weak var viewController: MovieListViewController?


    init(viewController: MovieListViewController) {
        self.viewController = viewController
    }
}


extension MovieListPresenter {

    func updateView(with movies: [Movie]) {
        DispatchQueue.main.async {
            guard let viewController = self.viewController else { return }

            viewController.updateView(with: movies)
        }
    }
}
