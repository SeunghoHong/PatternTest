
import UIKit

import PinLayout


final class MovieListViewController: UIViewController {

    private let tableView = UITableView()

    private var movies: [Movie] = []
    public var interactor: MovieListInteractor?


    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
        self.layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.interactor?.loadMovies()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}


extension MovieListViewController {

    private func setup() {
        self.title = "Movies"
        self.view.backgroundColor = .lightGray

        self.tableView.rowHeight = 60.0
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.view.addSubview(self.tableView)
    }

    private func layout() {
        self.tableView.pin
            .all()
    }
}


extension MovieListViewController {

    func updateView(with movies: [Movie]) {
        self.movies = movies
        self.tableView.reloadData()
    }
}


extension MovieListViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return self.movies.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let movie = self.movies[indexPath.row]

        cell.backgroundColor = .white
        cell.textLabel?.text = movie.title

        return cell
    }
}
