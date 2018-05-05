import Foundation
import UIKit

class LandingNavigator: Navigator {
    enum Destination {
        case feed(FeedPresenter)
    }

    private weak var navigationController: UINavigationController?
    
    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Navigator
    func navigate(to destination: Destination) {
        let viewController = makeViewController(for: destination)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Private
    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .feed(let presenter):
            return ViewControllerFactory.makeFeedViewController(presenter)
        }
    }
}
