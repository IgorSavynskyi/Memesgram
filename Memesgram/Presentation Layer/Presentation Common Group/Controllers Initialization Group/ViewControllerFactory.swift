import UIKit
import SafariServices

class ViewControllerFactory {
    
    static func makeFeedViewController(_ presenter: FeedPresenter) -> UIViewController {
        let vc: FeedViewController = Storyboard.main.instantiateViewController()
        vc.output = presenter
        presenter.view = vc
        return vc
    }
    
    static func makeWebViewController(_ url: URL, delegate: SFSafariViewControllerDelegate) -> UIViewController {
        let vc = SFSafariViewController(url: url)
        vc.delegate = delegate
        vc.preferredControlTintColor = .headlineColor
        return vc
    }
}
