import Foundation
import UIKit
import SafariServices

class LandingNavigator: NSObject, Navigator {
    enum Destination {
        case feed(FeedPresenter)
        case webPage(URL)
    }

    private weak var navigationController: UINavigationController?
    
    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Navigator
    func navigate(to destination: Destination, transition: TransitionType) {
        let vc = viewController(for: destination)
        switch transition {
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        case .modal:
            navigationController?.present(vc, animated: true, completion: nil)
        }
    }
    
    // MARK: - Private API
    private func viewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .feed(let presenter):
            return ViewControllerFactory.makeFeedViewController(presenter)
        case .webPage(let url):
            return ViewControllerFactory.makeWebViewController(url, delegate: self)
        }
    }
}

extension LandingNavigator: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
