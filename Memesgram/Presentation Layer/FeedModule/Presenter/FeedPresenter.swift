import Foundation

class FeedPresenter {
    weak var view: FeedViewInput!
    private lazy var linkService = LinkService()
    
    // MARK: - Private API
    
    private func generateRequestParameters() -> LinksRequestParameters {
        let params = LinksRequestParameters.init(after: "",
                                                 before: "",
                                                 limit: 50,
                                                 requestPeriod: LinksRequestParameters.TimePeriod.week.rawValue)
        return params
    }
}


extension FeedPresenter: FeedViewOutput {
    func didRequestLinksAction() {
        let params = generateRequestParameters()
        linkService.getTopLinks(params) { [weak self] (result) in
            switch result {
            case .success(let models):
                print("✅SUCCESS \(models.count)")
            case .failure(let error):
                print("❌Failure \(error.localizedDescription)")
            }
        }
    }
}
