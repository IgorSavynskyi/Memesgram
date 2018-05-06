import UIKit

class FeedViewController: UIViewController {
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var logoLabel: UILabel!

    var output: FeedViewOutput!
    lazy private var feedDisplay = FeedDisplayManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        var ip: IndexPath?
        if let topCell = collectionView?.visibleCells.first {
            ip = collectionView?.indexPath(for: topCell)
        }
        
        coordinator.animate(alongsideTransition: { (context) in
            self.collectionView?.collectionViewLayout.invalidateLayout()
        }) { (context) in
            if let ip = ip {
                self.collectionView?.scrollToItem(at: ip, at: .top, animated: true)
            }
        }
    }
    
    // MARK: - Private API
    
    private func showCollectionViewIfNeeded() {
        DispatchQueue.main.async {
            if self.collectionView.alpha == 0 {
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                    self.collectionView.alpha = 1
                    self.logoLabel.alpha = 0.0
                }, completion: nil)
            }
        }
    }
}

// MARK: - FeedViewInput
extension FeedViewController: FeedViewInput {
    func setupInitialState() {
        view.backgroundColor = .headlineColor
        feedDisplay.collectionView = collectionView
        collectionView.alpha = 0
    }
    
    func renderLinks(_ links: [LinkViewModel]) {
        showCollectionViewIfNeeded()
        feedDisplay.renderLinks(links)
    }
}


