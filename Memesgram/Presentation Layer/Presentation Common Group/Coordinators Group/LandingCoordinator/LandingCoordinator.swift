import Foundation

class LandingCoordinator {
    private let navigator: LandingNavigator
    
    init(navigator: LandingNavigator) {
        self.navigator = navigator
    }
    
    // MARK: - Private API
    
    private func runFeedFlow() {
        let feedPresenter = FeedPresenter()
        let feedDestination = LandingNavigator.Destination.feed(feedPresenter)
        navigator.navigate(to: feedDestination)
    }
}

extension LandingCoordinator: Coordinator {
    
    func start() {
        runFeedFlow()
    }
}
