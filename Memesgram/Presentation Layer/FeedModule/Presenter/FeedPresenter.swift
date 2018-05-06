import Foundation

class FeedPresenter {
    weak var view: FeedViewInput!
    private lazy var linkService = LinkService()
    private lazy var paginator = FeedPaginator()
    
    // MARK: - Private API
    
    private func requestNewLinks() {
        linkService.getTopLinks(paginator.toRequestParams) { [weak self] (result) in
            switch result {
            case .success(let page):
                print("✅SUCCESS \(page.links.count) AFTER: \(page.after)")
                self?.updatePaginator(with: page.after)
                self?.view.renderLinks(page.links)
            case .failure(let error):
                print("❌Failure \(error.localizedDescription)")
                self?.view.showError(title: nil, message: error.localizedDescription)
            }
        }
    }
    
    private func updatePaginator(with newAfter: String?) {
        paginator.after = newAfter ?? ""
    }
}

// MARK: - FeedViewOutput
extension FeedPresenter: FeedViewOutput {
    
    func viewIsReady() {
        view.setupInitialState()
        requestNewLinks()
    }
    
    // MARK: - FeedDisplayDelegate {
    func lackOfItemsSignal() {
        requestNewLinks()
    }
}
