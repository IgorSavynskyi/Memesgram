import UIKit

class ViewControllerFactory {
    
    static func makeFeedViewController(_ presenter: FeedPresenter) -> UIViewController {
        let vc: FeedViewController = Storyboard.main.instantiateViewController()
        vc.output = presenter
        presenter.view = vc
        return vc
    }
}
