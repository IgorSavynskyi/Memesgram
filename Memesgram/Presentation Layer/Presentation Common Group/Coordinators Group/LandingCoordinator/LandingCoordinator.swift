import Foundation

class LandingCoordinator {
    private let navigator: LandingNavigator
    
    init(navigator: LandingNavigator) {
        self.navigator = navigator
    }
    
    // MARK: - Private API
    
    private func runFeedFlow() {
        let presenter = FeedPresenter()
        presenter.moduleDelegate = self
        navigator.navigate(to: .feed(presenter), transition: .push)
    }
}

extension LandingCoordinator: Coordinator {
    func start() {
        runFeedFlow()
    }
}

extension LandingCoordinator: FeedModuleDelegate {
    func openUrl(_ url: URL) {
        navigator.navigate(to: .webPage(url), transition: .modal)
    }
}
