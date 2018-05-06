import Foundation

protocol FeedViewInput: class, ErrorAlertPresentable {
    func setupInitialState()
    func renderLinks(_ links: [LinkViewModel])
}

protocol FeedViewOutput: FeedDisplayDelegate {
    func viewIsReady()
}
