import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor : UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor : UIColor.clear], for: .highlighted)
        
        let mainViewController = MainViewController()
        mainViewController.reactor = MainViewReactor()
        mainViewController.view.backgroundColor = .white

        let navigationViewController = UINavigationController(rootViewController: mainViewController)
        navigationViewController.setNavigationBarHidden(false, animated: false)

        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()

        return true
    }

}
