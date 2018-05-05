import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var rootCoordinator: Coordinator = makeRootCoonrdinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        rootCoordinator.start()
        return true
    }
    
    // MARK: - Private API
    
    private func makeRootCoonrdinator() -> Coordinator {
        let navigator = makeRootNavigator()
        return LandingCoordinator(navigator: navigator)
    }
    
    private func makeRootNavigator() -> LandingNavigator {
        if let rootNav = window?.rootViewController as? UINavigationController {
            return LandingNavigator(navigationController: rootNav)
        } else {
            fatalError("Unexpected root view controller value")
        }
    }
}

