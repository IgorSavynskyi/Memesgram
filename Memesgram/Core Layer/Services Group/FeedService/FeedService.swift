import Foundation

class FeedService {
    typealias GetLinksCompletion = (_ result: Result<LinksPage>) -> Void

    private var networkService = NetworkService()

    // MARK: - API
    
    func getTopLinks(_ params: LinksRequestParameters, completion: @escaping GetLinksCompletion) {
        let request = Request(method: .get, endpoint: EndPoint.top, params: params.jsonDict)
        
        networkService.execute(request) { (result: Result<LinkResponseItem>) in
            switch result {
            case .success(let response):
                let models = self.convertResponseToViewModels(response.data.children)
                let page = LinksPage(links: models, after: response.data.after)
                completion(.success(page))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private API
    
    private func convertResponseToViewModels(_ responseItems: [LinkResponseItem.LinkChildren]) -> [LinkViewModel] {
        let mapped = responseItems.map {
            return LinkViewModel(id: $0.data.id,
                                 name: $0.data.name,
                                 author: $0.data.author,
                                 created: Date(timeIntervalSince1970: TimeInterval($0.data.created_utc)),
                                 title: $0.data.title,
                                 commentCount: $0.data.num_comments,
                                 thumbnail: $0.data.thumbnail,
                                 url: $0.data.url)
        }
        
        return mapped
    }

}
