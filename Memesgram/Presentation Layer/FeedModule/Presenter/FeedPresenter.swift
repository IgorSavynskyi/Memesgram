import Foundation

class FeedPresenter {
    weak var view: FeedViewInput!
    weak var moduleDelegate: FeedModuleDelegate?
    
    private lazy var feedService = FeedService()
    private lazy var paginator = FeedPaginator()
    
    // MARK: - Private API
    
    private func requestNewLinks() {
        feedService.getTopLinks(paginator.toRequestParams) { [weak self] (result) in
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
    
    // MARK: - MediaLinkCellDelegate
    func didOpenMediaAction(for link: LinkViewModel) {
        if let urlStr = link.url, let url = URL(string: urlStr) {
            moduleDelegate?.openUrl(url)
        }
    }
    
}
