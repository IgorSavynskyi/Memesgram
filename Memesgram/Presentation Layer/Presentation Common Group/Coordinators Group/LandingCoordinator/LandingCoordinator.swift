import Foundation

class LandingCoordinator {
    private let navigator: LandingNavigator
    
    init(navigator: LandingNavigator) {
        self.navigator = navigator
    }
    
    // MARK: - Private API
    
    private func runFeedFlow() {
        let presenter = FeedPresenter()
        navigator.navigate(to: .feed(presenter))
    }
}

extension LandingCoordinator: Coordinator {

    func start() {
        runFeedFlow()
    }
}
