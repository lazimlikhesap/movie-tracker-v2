import UIKit

class MovieDetailVC: UIViewController {
    
    // Variables
    var movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
        super.init(nibName: "MovieDetailVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


}
