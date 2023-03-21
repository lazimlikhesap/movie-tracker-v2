import Foundation
import Alamofire

protocol MoviesDelegate {
    func didUpdateMovies(_ movies: MoviesModel?)
    func didFailWithError(error: Error?)
}

struct MoviesViewModel {

    // Variables
    let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=9923e05df8d5661186572a8659e8575d&language=en-US&page=1"
    var delegate: MoviesDelegate?
    
    
    func fetchMovies() {
        AF.request(url, method: .get).responseData { response in
                switch response.result {
                case .success:
                    guard let movies = parseJSON(response.data!) else {
                        print("ERROR")
                        return
                    }
                    self.delegate?.didUpdateMovies(movies)
                    
                case let .failure(error):
                    delegate?.didFailWithError(error: error)
                }
            }
    }
    
    func parseJSON(_ moviesData: Data) -> MoviesModel? {
        do {
            return try JSONDecoder().decode(MoviesModel.self, from: moviesData)
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
