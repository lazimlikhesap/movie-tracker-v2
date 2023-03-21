import UIKit
import SDWebImage

class MoviesVC: UIViewController {
    // IBOutlets
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // Variables
    var movies: [Movie] = []
    var mainManager = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.register(UINib(nibName: K.movieCellNibName, bundle: nil), forCellReuseIdentifier: K.movieCellName)

        mainManager.delegate = self

        indicator.startAnimating()
        mainManager.fetchMovies()
    }
    
    func configure() {
        self.title = "Moowift"
        let searchBarButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
        let profileBarButton = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: nil)
        searchBarButton.imageInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
        navigationItem.rightBarButtonItems = [profileBarButton, searchBarButton]
    }

}

//MARK: - UITableViewDataSource
extension MoviesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        let cell = movieTableView.dequeueReusableCell(withIdentifier: K.movieCellName, for: indexPath) as! MovieCell
        cell.titleLabel.text = movie.originalTitle
        

        let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500/\(movie.backdropPath ?? "")")
        print(imageUrl!)
        cell.posterImage.sd_setImage(with: imageUrl)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let movieDetailVC = MovieDetailVC(movieId: movie.id!)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(movieDetailVC, animated: true)
        }
    }
}


//MARK: - MainManagerDelegate
extension MoviesVC: MoviesDelegate {
    func didUpdateMovies(_ movies: MoviesModel?) {
        DispatchQueue.main.async {
            self.movies = movies?.results ?? []
            self.movieTableView.reloadData()
            self.indicator.stopAnimating()
        }
    }
    
    func didFailWithError(error: Error?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present.self(self, animated: true)
        }
    }

}
