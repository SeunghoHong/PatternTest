
import Foundation


class MovieListInteractor {

    private var presenter: MovieListPresenter


    init(presenter: MovieListPresenter) {
        self.presenter = presenter
    }
}


extension MovieListInteractor {

    func loadMovies(/* with service */) {
        let jsonString = """
        [
            {
                "title": "2001: A Space Odyssey",
                "year": 1968,
                "imdbRating": 8.3,
            },
            {
                "title": "Aliens",
                "year": 1986,
                "imdbRating": 8.3,
            },
            {
                "title": "Attack of the Clones",
                "year": 2002,
                "imdbRating": 6.5,
            },
            {
                "title": "Batman",
                "year": 1989,
                "imdbRating": 7.5,
            },
            {
                "title": "Beauty & the Beast",
                "year": 1991,
                "imdbRating": 7.1,
            },
            {
                "title": "The Dark Knight",
                "year": 2008,
                "imdbRating": 9,
            },
            {
                "title": "The Dark Knight Rises",
                "year": 2012,
                "imdbRating": 8.4,
            },
            {
                "title": "Dead man walking",
                "year": 1995,
                "imdbRating": 7.5,
            },
            {
                "title": "The Godfather",
                "year": 1972,
                "imdbRating": 9.2,
            },
            {
                "title": "The Godfather II",
                "year": 1974,
                "imdbRating": 9,
            },
            {
                "title": "Gravity",
                "year": 2013,
                "imdbRating": 7.7,
            },
            {
                "title": "The Hustler",
                "year": 1961,
                "imdbRating": 8,
            },
            {
                "title": "The Incredibles",
                "year": 2004,
                "imdbRating": 8,
            },
            {
                "title": "Jaws",
                "year": 1975,
                "imdbRating": 8,
            },
            {
                "title": "Life is Beautiful",
                "year": 1997,
                "imdbRating": 8.6,
            },
            {
                "title": "A Man For All Seasons",
                "year": 1966,
                "imdbRating": 7.7,
            },
            {
                "title": "The Matrix",
                "year": 1999,
                "imdbRating": 8.7,
            },
            {
                "title": "Raging Bull",
                "year": 1980,
                "imdbRating": 8.2,
            },
            {
                "title": "Ratatouille",
                "year": 2007,
                "imdbRating": 8,
            },
            {
                "title": "Return of the Jedi",
                "year": 1983,
                "imdbRating": 8.3,
            }
        ]
        """

        guard let jsonData = jsonString.data(using: .utf8),
              let movies = try? JSONDecoder().decode([Movie].self, from: jsonData)
        else { return }

        self.presenter.updateView(with: movies)
    }
}


extension MovieListInteractor {

    func processMovies(_ movies: [Movie]) -> [Movie] {
        return movies.filter { $0.imdbRating > 0.5 }
    }
}
