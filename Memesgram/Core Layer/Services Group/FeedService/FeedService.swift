class FeedService {
    typealias GetLinksCompletion = (_ result: Result<LinksPage>) -> Void

    private var networkService = NetworkService()

    // MARK: - API
    func getTopLinks(_ params: LinksRequestParameters, completion: @escaping GetLinksCompletion) {
        let request = Request(method: .get, endpoint: EndPoint.top, params: params.jsonDict)
        
        networkService.execute(request) { (result: Result<LinkResponseItem>) in
            switch result {
            case .success(let response):
                let models = self.responseToViewModels(response.data.children)
                let page = LinksPage(links: models, after: response.data.after)
                completion(.success(page))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private API
    private func responseToViewModels(_ responseItems: [LinkResponseItem.LinkChildren]) -> [LinkViewModel] {
        return responseItems.map { LinkViewModel($0.data) }
    }

}
