import Foundation

protocol FeedViewInput: class, AlertPresentable {
    func setupInitialState()
    func renderLinks(_ links: [LinkViewModel])
    func showContextActivityIndicator(_ value: Bool)
}

protocol FeedViewOutput: FeedDisplayDelegate {
    func viewIsReady()
}
