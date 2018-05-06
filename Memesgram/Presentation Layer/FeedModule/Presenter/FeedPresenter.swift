import Foundation
import UIKit

class FeedPresenter: NSObject {
    weak var view: FeedViewInput!
    weak var moduleDelegate: FeedModuleDelegate?
    
    private lazy var feedService = FeedService()
    private lazy var paginator = FeedPaginator()
    
    // MARK: - Private API
    
    private func requestNewLinks() {
        feedService.getTopLinks(paginator.toRequestParams) { [weak self] (result) in
            switch result {
            case .success(let page):
                self?.updatePaginator(with: page.after)
                self?.view.renderLinks(page.links)
            case .failure(let error):
                self?.view.showAlert(title: nil, message: error.localizedDescription)
            }
        }
    }
    
    private func updatePaginator(with newAfter: String?) {
        paginator.after = newAfter ?? ""
    }
    
    private func saveImageToGallery(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            view.showAlert(title: "Save error", message: error.localizedDescription)
        } else {
            view.showAlert(title: "Saved", message: "✅")
        }
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
    
    func didSaveMediaAction(for link: LinkViewModel) {
        guard let urlStr = link.url, let url = URL(string: urlStr) else {
            view.showAlert(title: nil, message: "Ooops. Please try later")
            return
        }
        
        let imageDownloader = ImageDownloader()
        view.showContextActivityIndicator(true)
        
        imageDownloader.downloadImage(from: url) {[weak self] (image, error) in
            if let image = image {
                self?.saveImageToGallery(image)
            } else {
                self?.view.showAlert(title: nil, message: error?.localizedDescription)
            }
            self?.view.showContextActivityIndicator(false)
        }
    }
    
}
