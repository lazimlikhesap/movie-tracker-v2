import UIKit

class MainTabbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        configure()
    }
    
    func configure(){
        createTabbar()
    }
    
    func createTabbar(){
        UITabBar.appearance().tintColor = .label
        setViewControllers([createMoviesNavigationController(), createSearchNavigationController(), createProfileNavigationController()], animated: true)
        
    }
    
    func createMoviesNavigationController() -> UINavigationController {
        let moviesVC = UINavigationController(rootViewController: MoviesVC())
        moviesVC.tabBarItem.image = UIImage(systemName: "house")
        moviesVC.title = "Home"
        return moviesVC
    }
    
    func createSearchNavigationController() -> UINavigationController {
        let searchVC = UINavigationController(rootViewController: SearchVC())
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        searchVC.title = "Search"
        return searchVC
    }
    
    func createProfileNavigationController() -> UINavigationController {
        let profileVC = UINavigationController(rootViewController: ProfileVC())
        profileVC.tabBarItem.image = UIImage(systemName: "person")
        profileVC.title = "Profile"
        return profileVC
    }
}
